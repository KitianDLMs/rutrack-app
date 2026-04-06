import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';

class ClientMapBookingInfoState extends Equatable {

  final Completer<GoogleMapController>? controller;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;
  final Position? position;

  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;

  final Resource? responseTimeAndDistance;
  final Resource? responseClientRequest;

  final BlocFormItem fareOffered;

  // NUEVOS CAMPOS
  final BlocFormItem cargoWeight;
  final String cargoWeightUnit;
  final String truckTypeRequired;
  final String cargoType;
  final bool helpersRequired;
  final bool requiresCrane;
  final bool fragileCargo;

  ClientMapBookingInfoState({
    this.position,
    this.controller,
    this.cameraPosition = const CameraPosition(
      target: LatLng(-33.138232, -70.799815),
      zoom: 14.0
    ),
    this.pickUpLatLng,
    this.destinationLatLng,
    this.pickUpDescription = '',
    this.destinationDescription = '',
    this.markers = const <MarkerId, Marker>{},
    this.polylines = const <PolylineId, Polyline>{},
    this.responseTimeAndDistance,
    this.responseClientRequest,
    this.fareOffered = const BlocFormItem(error: 'Ingresa la tarifa'),

    this.cargoWeight = const BlocFormItem(error: 'Ingresa el peso de la carga'),
    this.cargoWeightUnit = 'KG',
    this.truckTypeRequired = 'Camioneta',
    this.cargoType = 'General',
    this.helpersRequired = false,
    this.requiresCrane = false,
    this.fragileCargo = false,
  });

  ClientMapBookingInfoState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    LatLng? pickUpLatLng,
    LatLng? destinationLatLng,
    String? pickUpDescription,
    String? destinationDescription,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    Resource? responseTimeAndDistance,
    Resource? responseClientRequest,
    BlocFormItem? fareOffered,

    BlocFormItem? cargoWeight,
    String? cargoWeightUnit,
    String? truckTypeRequired,
    String? cargoType,
    bool? helpersRequired,
    bool? requiresCrane,
    bool? fragileCargo,
  }) {
    return ClientMapBookingInfoState(
      position: position ?? this.position,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      pickUpLatLng: pickUpLatLng ?? this.pickUpLatLng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpDescription: pickUpDescription ?? this.pickUpDescription,
      destinationDescription: destinationDescription ?? this.destinationDescription,
      responseTimeAndDistance:
          responseTimeAndDistance ?? this.responseTimeAndDistance,
      responseClientRequest:
          responseClientRequest ?? this.responseClientRequest,
      fareOffered: fareOffered ?? this.fareOffered,

      cargoWeight: cargoWeight ?? this.cargoWeight,
      cargoWeightUnit: cargoWeightUnit ?? this.cargoWeightUnit,
      truckTypeRequired: truckTypeRequired ?? this.truckTypeRequired,
      cargoType: cargoType ?? this.cargoType,
      helpersRequired: helpersRequired ?? this.helpersRequired,
      requiresCrane: requiresCrane ?? this.requiresCrane,
      fragileCargo: fragileCargo ?? this.fragileCargo,
    );
  }

  @override
  List<Object?> get props => [
    position,
    markers,
    polylines,
    controller,
    cameraPosition,
    pickUpLatLng,
    destinationLatLng,
    pickUpDescription,
    destinationDescription,
    responseTimeAndDistance,
    responseClientRequest,
    fareOffered,
    cargoWeight,
    cargoWeightUnit,
    truckTypeRequired,
    cargoType,
    helpersRequired,
    requiresCrane,
    fragileCargo,
  ];
}