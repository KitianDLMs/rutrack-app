import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:localdriver/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';
import 'package:localdriver/src/presentation/pages/client/home/bloc/ClientHomeState.dart';

class ClientHomeTutBloc extends Bloc<ClientHomeEvent, ClientHomeState> {

  AuthUseCases authUseCases;

  ClientHomeTutBloc(this.authUseCases): super(ClientHomeState()) {
    on<ChangeDrawerPage>((event, emit) {
      emit(
        state.copyWith(
          pageIndex: event.pageIndex
        )
      );
    });

    on<Logout>((event, emit) async {
      await authUseCases.logout.run();
    });
  }

}