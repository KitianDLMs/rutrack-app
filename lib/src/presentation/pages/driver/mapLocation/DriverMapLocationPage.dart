import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIO.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:localdriver/src/domain/models/ClientRequestResponse.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';
import 'package:localdriver/src/presentation/pages/driver/clientRequests/DriverClientRequestsPage.dart';
import 'package:localdriver/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsBloc.dart';
import 'package:localdriver/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsEvent.dart';
import 'package:localdriver/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationEvent.dart';
import 'package:localdriver/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationBloc.dart';
import 'package:localdriver/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationState.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DriverMapLocationPage extends StatefulWidget {
  const DriverMapLocationPage({super.key});

  @override
  State<DriverMapLocationPage> createState() => _DriverMapLocationPageState();
}

class _DriverMapLocationPageState extends State<DriverMapLocationPage> {
  final Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DriverMapLocationBloc>().add(DriverMapLocationInitEvent());
      context.read<DriverMapLocationBloc>().add(FindPosition());
      context.read<DriverClientRequestsBloc>().add(InitDriverClientRequest());
      context.read<DriverClientRequestsBloc>().add(ListenNewClientRequestSocketIO());    
    });
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      body: BlocListener<DriverMapLocationBloc, DriverMapLocationState>(
        listener: (context, state) async {
          if (_controller.isCompleted) {
            final controller = await _controller.future;

            controller.animateCamera(
              CameraUpdate.newCameraPosition(state.cameraPosition),
            );
          }
        },
        child: BlocBuilder<DriverMapLocationBloc, DriverMapLocationState>(
          builder: (context, state) {          
            final requestState = context.watch<DriverClientRequestsBloc>().state;
             int total = 0;

            // if (requestState.response is Success) {
            //   print('requestState.response ${requestState.response}');
            //   // total = (requestState.response.data as List).length;
            // }

            if (requestState.response is Success<List<ClientRequestResponse>>) {
              final data = (requestState.response as Success<List<ClientRequestResponse>>).data;
              for (var item in data) {
                print('REQUEST: ${item.toJson()}');
              }
              print('LISTA: $data');
              print('TOTAL: ${data.length}');

              total = data.length;
            }

            print('TOTAL REQUESTS $total');
            print('pendingRequests ${state.pendingRequests}');
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: state.cameraPosition,
                  markers: Set<Marker>.of(state.markers.values),
                  onMapCreated: (GoogleMapController controller) {
                    controller.setMapStyle(
                        '[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                    }

                    Future.delayed(Duration(milliseconds: 300), () {
                      context.read<DriverMapLocationBloc>().add(FindPosition());
                    });
                  },
                ),                
                  Positioned(
                    top: 60,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DriverClientRequestsPage(),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 5)
                              ],
                            ),
                            child:
                                Icon(Icons.notifications, color: Colors.black),
                          ),                          
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                              ),
                              child: Text(
                                '$total',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 30),
                  child: ToggleSwitch(
                    minWidth: 150.0,
                    minHeight: 50,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [Colors.lightGreenAccent],
                      [Colors.red]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey[400],
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    customTextStyles: [
                      TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)
                    ],
                    labels: ['DISPONIBLE', 'DESCONECTADO'],
                    radiusStyle: true,
                    onToggle: (index) {
                      if (index == 0) {
                        context.read<BlocSocketIO>().add(ConnectSocketIO());
                        context
                            .read<DriverMapLocationBloc>()
                            .add(FindPosition());
                      } else if (index == 1) {
                        context.read<BlocSocketIO>().add(DisconnectSocketIO());
                        context
                            .read<DriverMapLocationBloc>()
                            .add(StopLocation());
                      }
                      print('switched to: $index');
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
