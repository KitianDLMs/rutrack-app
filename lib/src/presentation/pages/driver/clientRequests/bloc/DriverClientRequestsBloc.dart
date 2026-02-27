import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIO.dart';
import 'package:localdriver/src/domain/models/AuthResponse.dart';
import 'package:localdriver/src/domain/models/ClientRequest.dart';
import 'package:localdriver/src/domain/models/ClientRequestResponse.dart';
import 'package:localdriver/src/domain/models/DriverPosition.dart';
import 'package:localdriver/src/domain/models/DriverTripRequest.dart';
import 'package:localdriver/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:localdriver/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:localdriver/src/domain/useCases/driver-trip-request/DriverTripRequestUseCases.dart';
import 'package:localdriver/src/domain/useCases/drivers-position/DriversPositionUseCases.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';
import 'package:localdriver/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsEvent.dart';
import 'package:localdriver/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsState.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';

class DriverClientRequestsBloc extends Bloc<DriverClientRequestsEvent, DriverClientRequestsState> {

  AuthUseCases authUseCases;
  DriversPositionUseCases driversPositionUseCases;
  ClientRequestsUseCases clientRequestsUseCases;
  DriverTripRequestUseCases driverTripRequestUseCases;
  BlocSocketIO blocSocketIO;

  DriverClientRequestsBloc(this.blocSocketIO, this.clientRequestsUseCases, this.driversPositionUseCases, this.authUseCases, this.driverTripRequestUseCases): super(DriverClientRequestsState()) {

    on<InitDriverClientRequest>((event, emit) async {
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      Resource responseDriverPosition = await driversPositionUseCases.getDriverPosition.run(authResponse.user.id!);
      emit(
        state.copyWith(
          response: Loading(),
          idDriver: authResponse.user.id!,
          responseDriverPosition: responseDriverPosition
        )
      );
      add(GetNearbyTripRequest());
    });

    on<GetNearbyTripRequest>((event, emit) async{
      final responseDriverPosition = state.responseDriverPosition;
      if (responseDriverPosition is Success) {
        DriverPosition driverPosition = responseDriverPosition.data as DriverPosition;
        Resource<List<ClientRequestResponse>> response = await clientRequestsUseCases.getNearbyTripRequest.run(driverPosition.lat, driverPosition.lng);
        emit(
          state.copyWith(
            response: response,
          )
        );
      }
    });

    on<CreateDriverTripRequest>((event, emit) async {
      Resource<bool> response = await driverTripRequestUseCases.createDriverTripRequest.run(event.driverTripRequest);
      emit(
        state.copyWith(responseCreateDriverTripRequest: response)
      );
      if (response is Success) {
        add(EmitNewDriverOfferSocketIO(idClientRequest: event.driverTripRequest.idClientRequest));
      }
    });

    on<FareOfferedChange>((event, emit) {
      emit(
        state.copyWith(
          fareOffered: event.fareOffered
        )
      );
    });

    on<ListenNewClientRequestSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.on('created_client_request', (data) {
          add(GetNearbyTripRequest());
        });
      }
    });

    on<EmitNewDriverOfferSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.emit('new_driver_offer', {
          'id_client_request': event.idClientRequest
        });
      }
    });

  }

}