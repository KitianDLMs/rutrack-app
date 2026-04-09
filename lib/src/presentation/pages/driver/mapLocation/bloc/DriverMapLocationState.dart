import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localdriver/src/domain/models/ClientRequestResponse.dart' show ClientRequestResponse;
import 'package:localdriver/src/domain/models/PlacemarkData.dart';
import 'package:socket_io_client/socket_io_client.dart';

class DriverMapLocationState extends Equatable {

  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;
  final int? idDriver;
  final int pendingRequests;
  final List<ClientRequestResponse> pendingList;

  DriverMapLocationState({
    this.position,
    this.controller,
    this.cameraPosition = const CameraPosition(target: LatLng(-33.1348611,-70.8001026), zoom: 14.0),    
    this.markers = const <MarkerId, Marker>{},
    this.idDriver,
    this.pendingList = const [],
    this.pendingRequests = 0,
  });

  DriverMapLocationState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    PlacemarkData? placemarkData,
    LatLng? pickUpLatLng,
    LatLng? destinationLatLng,
    String? pickUpDescription,
    String? destinationDescription,
    Map<MarkerId, Marker>? markers,
    Socket? socket,
    int? idDriver,
    List<ClientRequestResponse>? pendingList,
    int? pendingRequests,
  }) {
    return DriverMapLocationState(
      position: position ?? this.position,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      idDriver: idDriver ?? this.idDriver,
      pendingList: pendingList ?? this.pendingList,
      pendingRequests: pendingRequests ?? this.pendingRequests,
    );
  }


  @override
  List<Object?> get props => [position, markers, controller, cameraPosition,  idDriver, pendingList, pendingRequests,];

}