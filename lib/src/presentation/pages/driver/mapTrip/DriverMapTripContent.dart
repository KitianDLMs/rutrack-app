import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localdriver/src/domain/models/ClientRequestResponse.dart';
import 'package:localdriver/src/domain/models/StatusTrip.dart';
import 'package:localdriver/src/domain/models/TimeAndDistanceValues.dart';
import 'package:localdriver/src/presentation/pages/driver/mapTrip/bloc/DriverMapTripBloc.dart';
import 'package:localdriver/src/presentation/pages/driver/mapTrip/bloc/DriverMapTripState.dart';
import 'package:localdriver/src/presentation/pages/driver/mapTrip/bloc/DriverMapTripEvent.dart';
import 'package:flutter/services.dart';

class DriverMapTripContent extends StatelessWidget {
  DriverMapTripState state;
  ClientRequestResponse? clientRequest;
  TimeAndDistanceValues? timeAndDistanceValues;

  DriverMapTripContent(
      this.state, this.clientRequest, this.timeAndDistanceValues);

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
      height: MediaQuery.of(context).size.height * 0.50,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Color.fromARGB(255, 220, 220, 220),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              'DETALLES DEL VIAJE',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                _infoItem(
                  "Nombre",
                  clientRequest?.client?.name ?? '',
                  Icons.person,
                ),
                _infoItem(
                  "Teléfono",
                  clientRequest?.client?.phone ?? '',
                  Icons.phone,
                  onTap: () {
                    final phone = clientRequest?.client?.phone ?? '';
                    Clipboard.setData(ClipboardData(text: phone));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Número copiado"),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'VIAJE',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
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
            Row(
              children: [
                _infoItem(
                  "Camión",
                  clientRequest?.truckType ?? '-',
                  Icons.local_shipping,
                ),
              ],
            ),
            Row(
              children: [
                _infoItem(
                  "Descripción",
                  clientRequest?.cargoType ?? '-',
                  Icons.description_rounded,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(6),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "\$${clientRequest?.fareAssigned}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            state.statusTrip == StatusTrip.ARRIVED
                ? _actionButton(
                    'FINALIZAR VIAJE',
                    Icons.power_settings_new,
                    Colors.red,
                    () {
                      context.read<DriverMapTripBloc>().add(
                            UpdateStatusToFinished(),
                          );
                    },
                  )
                : _actionButton(
                    'NOTIFICAR LLEGADA',
                    Icons.check_circle,
                    Colors.green,
                    () {
                      context.read<DriverMapTripBloc>().add(
                            UpdateStatusToArrived(),
                          );
                    },
                  ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(
    String title,
    String value,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 18, color: Colors.blueAccent),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              SizedBox(height: 3),
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(
    String text,
    IconData icon,
    Color color,
    Function() onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _actionUpdateStatus(
      String option, IconData icon, Function() function) {
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
      height: MediaQuery.of(context).size.height * 0.55,
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
            }
          }
        },
      ),
    );
  }
}
