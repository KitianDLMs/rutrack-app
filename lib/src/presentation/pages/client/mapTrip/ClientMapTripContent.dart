import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localdriver/src/domain/models/ClientRequestResponse.dart';
import 'package:localdriver/src/domain/models/TimeAndDistanceValues.dart';
import 'package:localdriver/src/presentation/pages/client/mapTrip/bloc/ClientMapTripBloc.dart';
import 'package:localdriver/src/presentation/pages/client/mapTrip/bloc/ClientMapTripEvent.dart';
import 'package:localdriver/src/presentation/pages/client/mapTrip/bloc/ClientMapTripState.dart';
import 'package:localdriver/src/presentation/widgets/DefaultImageUrl.dart';

class ClientMapTripContent extends StatelessWidget {
  ClientMapTripState state;
  ClientRequestResponse? clientRequest;

  ClientMapTripContent(this.state, this.clientRequest);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context),
        Align(
            alignment: Alignment.bottomCenter,
            child: _cardBookingInfo(context)),
      ],
    );
  }

  Widget _cardBookingInfo(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.49,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 186, 186, 186),
                ]),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Datos del viaje', style: 
                  TextStyle(
                    color: Colors.black, 
                    fontSize: 25, 
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),),
              ),
              Row(
                children: [
                  _infoItem(
                    "Conductor",
                    "${clientRequest?.driver?.name ?? ''}",
                    Icons.person,
                  ),
                  _infoItem(
                    "Teléfono",
                    "${clientRequest?.driver?.phone ?? ''}",
                    Icons.phone,
                  ),
                ],
              ),
              Row(                              
                children: [
                  _infoItem(
                    "Estado",
                    "${clientRequest?.status ?? ''}",
                    Icons.info
                  )         
                ],
              ),
              Row(
                children: [
                  _infoItem(
                    "Vehículo",
                    clientRequest?.car?.brand ?? '',
                    Icons.local_shipping,
                  ),
                  _infoItem(
                    "Patente",
                    clientRequest?.car?.plate ?? '',
                    Icons.confirmation_number,
                  ),
                ],
              ),

              // ORIGEN + DESTINO
              Row(
                children: [
                  _infoItem(
                    "Desde",
                    clientRequest?.pickupDescription ?? '',
                    Icons.location_on,
                  ),
                  _infoItem(
                    "Hasta",
                    clientRequest?.destinationDescription ?? '',
                    Icons.flag,
                  ),
                ],
              ),

              // CARGA + TIPO CAMIÓN
              Row(
                children: [
                  _infoItem(
                    "Carga",
                    "${clientRequest?.requiredWeight ?? '-'} ${clientRequest?.weightUnit ?? ''}",
                    Icons.scale,
                  ),
                  _infoItem(
                    "Camión",
                    clientRequest?.truckType ?? '-',
                    Icons.fire_truck,
                  ),
                ],
              ),

              // AYUDANTES + GRÚA
              Row(
                children: [
                  _infoItem(
                    "Ayudantes",
                    clientRequest?.requireHelpers == true ? 'Sí' : 'No',
                    Icons.people,
                  ),
                  _infoItem(
                    "Grúa",
                    clientRequest?.requireCrane == true ? 'Sí' : 'No',
                    Icons.construction,
                  ),
                ],
              ),

              // PRECIO (full width)
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "\$${clientRequest?.fareAssigned}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _infoItem(String title, String value, IconData icon, {Widget? trailing}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 20, color: Colors.blueAccent),
                if (trailing != null) trailing
              ],
            ),
            SizedBox(height: 5),
            Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(height: 5),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _actionProfile(String option, IconData icon, Function() function) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 0, top: 15),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            option,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 19, 58, 213),
                      Color.fromARGB(255, 65, 173, 255),
                    ]),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _googleMaps(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.53,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: state.cameraPosition,
        markers: Set<Marker>.of(state.markers.values),
        polylines: Set<Polyline>.of(state.polylines.values),
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(
              '[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
          if (state.controller != null) {
            if (!state.controller!.isCompleted) {
              state.controller?.complete(controller);
              if (clientRequest != null) {
                context.read<ClientMapTripBloc>().add(AddMarkerPickup(
                    lat: clientRequest!.pickupPosition.lat,
                    lng: clientRequest!.pickupPosition.lng));
              }
            }
          }
        },
      ),
    );
  }
}
