import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIO.dart';
import 'package:localdriver/src/domain/models/AuthResponse.dart';
import 'package:localdriver/src/domain/models/ClientRequest.dart';
import 'package:localdriver/src/domain/models/TimeAndDistanceValues.dart';
import 'package:localdriver/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:localdriver/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:localdriver/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';
import 'package:localdriver/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoEvent.dart';
import 'package:localdriver/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoState.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';


class ClientMapBookingInfoBloc extends Bloc<ClientMapBookingInfoEvent, ClientMapBookingInfoState> {

  GeolocatorUseCases geolocatorUseCases;
  ClientRequestsUseCases clientRequestsUseCases;
  AuthUseCases authUseCases;
  BlocSocketIO blocSocketIO;
  

  ClientMapBookingInfoBloc(this.blocSocketIO, this.geolocatorUseCases, this.clientRequestsUseCases, this.authUseCases): super(ClientMapBookingInfoState()) {
    on<ClientMapBookingInfoInitEvent>((event, emit) async {
      Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(
        state.copyWith(
          pickUpLatLng: event.pickUpLatLng,
          destinationLatLng: event.destinationLatLng,
          pickUpDescription: event.pickUpDescription,
          destinationDescription: event.destinationDescription,
          controller: controller,
        )
      );
      BitmapDescriptor pickUpDescriptor = await geolocatorUseCases.createMarker.run('assets/img/pin_white.png');
      BitmapDescriptor destinationDescriptor = await geolocatorUseCases.createMarker.run('assets/img/flag.png');
      Marker markerPickUp = geolocatorUseCases.getMarker.run(
        'pickup',
        state.pickUpLatLng!.latitude,
        state.pickUpLatLng!.longitude,
        'Lugar de recogida',
        'Debes permancer aqui mientras llega el conductor',
        pickUpDescriptor
      );
      Marker markerDestination = geolocatorUseCases.getMarker.run(
        'destination',
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
        'Tu Destino',
        '',
        destinationDescriptor
      );
      emit(
        state.copyWith(
          markers: {
            markerPickUp.markerId: markerPickUp,
            markerDestination.markerId: markerDestination
          }
        )
      );
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      GoogleMapController googleMapController = await state.controller!.future;
      await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(event.lat, event.lng),
          zoom: 12,
          bearing: 0
        )
      ));
    });  

    on<FareOfferedChanged>((event, emit) {
      emit(
        state.copyWith(fareOffered: BlocFormItem(
          value: event.fareOffered.value,
          error: event.fareOffered.value.isEmpty ? 'Ingresa la tarifa' : null
        ))
      );
    });

    on<CargoWeightChanged>((event, emit) {
      emit(state.copyWith(
        cargoWeight: BlocFormItem(
          value: event.cargoWeight.value,
          error: event.cargoWeight.value.isEmpty ? 'Ingresa el peso' : null
        )
      ));
    });

    on<CargoWeightUnitChanged>((event, emit) {
      emit(state.copyWith(
        cargoWeightUnit: event.unit
      ));
    });

    on<TruckTypeChanged>((event, emit) {
      emit(state.copyWith(
        truckTypeRequired: event.type
      ));
    });

    on<CargoTypeChanged>((event, emit) {
      emit(state.copyWith(
        cargoType: event.type
      ));
    });

    on<HelpersRequiredChanged>((event, emit) {
      emit(state.copyWith(
        helpersRequired: event.value
      ));
    });

    on<RequiresCraneChanged>((event, emit) {
      emit(state.copyWith(
        requiresCrane: event.value
      ));
    });

    on<FragileCargoChanged>((event, emit) {
      emit(state.copyWith(
        fragileCargo: event.value
      ));
    });

   on<CreateClientRequest>((event, emit) async {

      print("CLICK CREATE REQUEST");

      emit(state.copyWith(responseClientRequest: Loading()));

      try {

        AuthResponse authResponse = await authUseCases.getUserSession.run();

        print("USER ID: ${authResponse.user.id}");

        print("FARE: ${state.fareOffered.value}");
        final request = ClientRequest(
          idClient: authResponse.user.id!, 
          fareOffered: double.tryParse(state.fareOffered.value) ?? 0, 
          pickupDescription: state.pickUpDescription, 
          destinationDescription: state.destinationDescription, 
          pickupLat: state.pickUpLatLng!.latitude, 
          pickupLng: state.pickUpLatLng!.longitude, 
          destinationLat: state.destinationLatLng!.latitude, 
          destinationLng: state.destinationLatLng!.longitude, 
          cargoWeight: double.tryParse(state.cargoWeight.value) ?? 0, 
          cargoWeightUnit: state.cargoWeightUnit, 
          truckTypeRequired: state.truckTypeRequired, 
          cargoType: state.cargoType, 
          helpersRequired: state.helpersRequired, 
          requiresCrane: state.requiresCrane, 
          fragileCargo: state.fragileCargo            
        );

        print("JSON QUE ENVIA FLUTTER:");
        print(request.toJson());

        Resource<int> response = await clientRequestsUseCases.createClientRequest.run(
          ClientRequest(
            idClient: authResponse.user.id!, 
            fareOffered: double.tryParse(state.fareOffered.value) ?? 0, 
            pickupDescription: state.pickUpDescription, 
            destinationDescription: state.destinationDescription, 
            pickupLat: state.pickUpLatLng!.latitude, 
            pickupLng: state.pickUpLatLng!.longitude, 
            destinationLat: state.destinationLatLng!.latitude, 
            destinationLng: state.destinationLatLng!.longitude, 
            cargoWeight: double.tryParse(state.cargoWeight.value) ?? 0, 
            cargoWeightUnit: state.cargoWeightUnit, 
            truckTypeRequired: state.truckTypeRequired, 
            cargoType: state.cargoType, 
            helpersRequired: state.helpersRequired, 
            requiresCrane: state.requiresCrane, 
            fragileCargo: state.fragileCargo            
          )
        );
      
        print("RESPONSE: ${response}");

        emit(
          state.copyWith(
            responseClientRequest: response
          )
        );

      } catch(e) {
        print("ERROR CREATE REQUEST: $e");
      }

    });

    on<EmitNewClientRequestSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.emit('new_client_request', {
            'id_client_request': event.idClientRequest
        });
      }
    });

    on<GetTimeAndDistanceValues>((event, emit) async {
      emit(
        state.copyWith(
          responseTimeAndDistance: Loading()
        )
      );
      Resource<TimeAndDistanceValues> response = await clientRequestsUseCases.getTimeAndDistance.run(
        state.pickUpLatLng!.latitude,
        state.pickUpLatLng!.longitude,
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
      );
      emit(
        state.copyWith(
          responseTimeAndDistance: response
        )
      );
    });
    

    on<AddPolyline>((event, emit) async {
      List<LatLng> polylineCoordinates = await geolocatorUseCases.getPolyline.run(state.pickUpLatLng!, state.destinationLatLng!);
      PolylineId id = PolylineId("MyRoute");
      Polyline polyline = Polyline(
        polylineId: id, 
        color: Colors.blueAccent, 
        points: polylineCoordinates,
        width: 6
      );
      emit(
        state.copyWith(
          polylines: {
            id: polyline
          }
        )
      );
    });

    

  }
}