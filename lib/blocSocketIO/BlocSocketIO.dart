import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIOState.dart';
import 'package:localdriver/main.dart';
import 'package:localdriver/src/domain/models/AuthResponse.dart';
import 'package:localdriver/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:localdriver/src/domain/useCases/socket/SocketUseCases.dart';
import 'package:socket_io_client/socket_io_client.dart';

class BlocSocketIO extends Bloc<BlocSocketIOEvent, BlocSocketIOState> {

  SocketUseCases socketUseCases;
  AuthUseCases authUseCases;

  BlocSocketIO(this.socketUseCases, this.authUseCases): super(BlocSocketIOState()) {

    on<ConnectSocketIO>((event, emit) {       
      Socket socket = socketUseCases.connect.run();
      emit(
        state.copyWith(socket: socket)
      );
    });

    on<DisconnectSocketIO>((event, emit) {
      socketUseCases.disconnect.run();
      emit(
        state.copyWith(socket: null)
      );
    });

    on<ListenDriverAssignedSocketIO>((event, emit) async{
      if (state.socket != null) {
        AuthResponse authResponse = await authUseCases.getUserSession.run();
        state.socket?.on('driver_assigned/${authResponse.user.id}', (data) {
          navigatorKey.currentState?.pushNamed('driver/map/trip', arguments: data['id_client_request']);
        });
      }
    });

  }

}