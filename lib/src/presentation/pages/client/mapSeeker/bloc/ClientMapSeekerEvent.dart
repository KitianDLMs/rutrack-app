import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class ClientMapSeekerEvent {}

class ClientMapSeekerInitEvent extends ClientMapSeekerEvent {}
class FindPosition extends ClientMapSeekerEvent {}
class ChangeMapCameraPosition extends ClientMapSeekerEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}

class OnCameraMove extends ClientMapSeekerEvent {
  CameraPosition cameraPosition;
  OnCameraMove({required this.cameraPosition});
}

class OnCameraIdle extends ClientMapSeekerEvent {}

class OnAutoCompletedPickUpSelected extends ClientMapSeekerEvent {
  double lat;
  double lng;
  String pickUpDescription;
  OnAutoCompletedPickUpSelected({required this.lat, required this.lng, required this.pickUpDescription});
}

class OnAutoCompletedDestinationSelected extends ClientMapSeekerEvent {
  double lat;
  double lng;
  String destinationDescription;
  OnAutoCompletedDestinationSelected({required this.lat, required this.lng, required this.destinationDescription});
}

class ListenDriversPositionSocketIO extends ClientMapSeekerEvent {}
class ListenDriversDisconnectedSocketIO extends ClientMapSeekerEvent {}
class RemoveDriverPositionMarker extends ClientMapSeekerEvent {
  final String idSocket;

  RemoveDriverPositionMarker({ required this.idSocket });
}
class AddDriverPositionMarker extends ClientMapSeekerEvent {

  final String idSocket;
  final int id;
  final double lat;
  final double lng;

  // NUEVA INFO DEL CAMIÓN
  final String? brand;
  final String? plate;
  final String? truckType;
  final String? maxWeight;
  final String? weightUnit;
  final bool? hasHelpers;
  final bool? hasCrane;
  final double? maxVolume;
  final String? color;

  AddDriverPositionMarker({
    required this.idSocket,
    required this.id,
    required this.lat,
    required this.lng,

    this.brand,
    this.plate,
    this.truckType,
    this.maxWeight,
    this.weightUnit,
    this.hasHelpers,
    this.hasCrane,
    this.maxVolume,
    this.color,
  });
}
