import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localdriver/src/domain/models/TimeAndDistanceValues.dart';
import 'package:localdriver/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoBloc.dart';
import 'package:localdriver/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoEvent.dart';
import 'package:localdriver/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoState.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';
import 'package:localdriver/src/presentation/widgets/DefaultIconBack.dart';
import 'package:localdriver/src/presentation/widgets/DefaultTextField.dart';

class ClientMapBookingInfoContent extends StatelessWidget {

  ClientMapBookingInfoState state;
  TimeAndDistanceValues timeAndDistanceValues;

  ClientMapBookingInfoContent(this.state, this.timeAndDistanceValues);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context),
        Align(
          alignment: Alignment.bottomCenter,
          child: _cardBookingInfo(context)
        ),
        Container(
          margin: EdgeInsets.only(top: 50, left: 20),
          child: DefaultIconBack()
        )
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
          ]
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Recoger en',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              subtitle: Text(
                state.pickUpDescription,
                style: TextStyle(
                  fontSize: 13
                ),
              ),
              leading: Icon(Icons.location_on),
            ),
            ListTile(
              title: Text(
                'Dejar en',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              subtitle: Text(
                state.destinationDescription,
                style: TextStyle(
                  fontSize: 13
                ),
              ),
              leading: Icon(Icons.my_location),
            ),
            ListTile(
              title: Text(
                'Tiempo y distancia aproximados',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              subtitle: Text(
                '${timeAndDistanceValues.distance.text} y ${timeAndDistanceValues.duration.text}',
                style: TextStyle(
                  fontSize: 13
                ),
              ),
              leading: Icon(Icons.timer),
            ),
            ListTile(
              title: Text(
                'Precios recomendados',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              subtitle: Text(
                '\$${timeAndDistanceValues.recommendedValue}',
                style: TextStyle(
                  fontSize: 13
                ),
              ),
              leading: Icon(Icons.money),
            ),
            DefaultTextField(
              margin: EdgeInsets.only(left: 15, right: 15),
              text: 'OFRECE TU TARIFA', 
              icon: Icons.attach_money, 
              keyboardType: TextInputType.phone,
              onChanged: (text) {
                context.read<ClientMapBookingInfoBloc>().add(FareOfferedChanged(fareOffered: BlocFormItem(value: text)));
              },
              validator: (value) {
                return state.fareOffered.error;
              },
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'DETALLES DE LA CARGA',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        
            // PESO
            DefaultTextField(
              margin: EdgeInsets.only(left: 15, right: 15),
              text: 'PESO DE LA CARGA',
              icon: Icons.scale,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                context.read<ClientMapBookingInfoBloc>().add(
                  CargoWeightChanged(
                    cargoWeight: BlocFormItem(value: text)
                  )
                );
              },
              validator: (value) {
                return state.cargoWeight.error;
              },
            ),
        
            DropdownButtonFormField(
              value: state.cargoWeightUnit,
              items: ['KG', 'TON']
                  .map((unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
                      ))
                  .toList(),
              onChanged: (value) {
                context.read<ClientMapBookingInfoBloc>().add(
                  CargoWeightUnitChanged(unit: value.toString())
                );
              },
              decoration: InputDecoration(
                labelText: 'Unidad de peso',
                prefixIcon: Icon(Icons.straighten),
              ),
            ),
        
            DropdownButtonFormField(
              value: state.truckTypeRequired,
              items: ['Camioneta', '3/4', 'Camión', 'Camión grande']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                context.read<ClientMapBookingInfoBloc>().add(
                  TruckTypeChanged(type: value.toString())
                );
              },
              decoration: InputDecoration(
                labelText: 'Tipo de camión requerido',
                prefixIcon: Icon(Icons.local_shipping),
              ),
            ),
        
            DropdownButtonFormField(
              value: state.cargoType,
              items: [
                'General',
                'Pallets',
                'Material de construcción',
                'Mudanza',
                'Maquinaria',
                'Frágil'
              ]
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                context.read<ClientMapBookingInfoBloc>().add(
                  CargoTypeChanged(type: value.toString())
                );
              },
              decoration: InputDecoration(
                labelText: 'Tipo de carga',
                prefixIcon: Icon(Icons.inventory),
              ),
            ),
        
            // AYUDANTES
            SwitchListTile(
              title: Text('Necesita ayudantes'),
              value: state.helpersRequired,
              onChanged: (value) {
                context.read<ClientMapBookingInfoBloc>().add(
                  HelpersRequiredChanged(value: value)
                );
              },
            ),
        
            SwitchListTile(
              title: Text('Necesita grúa'),
              value: state.requiresCrane,
              onChanged: (value) {
                context.read<ClientMapBookingInfoBloc>().add(
                  RequiresCraneChanged(value: value)
                );
              },
            ),
        
            SwitchListTile(
              title: Text('Carga frágil'),
              value: state.fragileCargo,
              onChanged: (value) {
                context.read<ClientMapBookingInfoBloc>().add(
                  FragileCargoChanged(value: value)
                );
              },
            ),
            _actionProfile(
              'BUSCAR CONDUCTOR',
              Icons.search,
              () {
                print('CLICK BUSCAR CONDUCTOR');
                context.read<ClientMapBookingInfoBloc>().add(CreateClientRequest());
              }
            )
          ],
        ),
      )
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
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
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
                ]
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
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
          controller.setMapStyle('[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
          if (!state.controller!.isCompleted) {
            state.controller?.complete(controller); 
          }
        },
      ),
    );
  }
}