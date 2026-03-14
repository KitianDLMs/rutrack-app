import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/src/domain/models/AuthResponse.dart';
import 'package:localdriver/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:localdriver/src/presentation/pages/profile/info/bloc/ProfileInfoEvent.dart';
import 'package:localdriver/src/presentation/pages/profile/info/bloc/ProfileInfoState.dart';
import 'package:localdriver/src/data/dataSource/local/SharefPref.dart'; // <--- Importa tu storage

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {

  final AuthUseCases authUseCases;
  final SharefPref storage = SharefPref(); // <--- Instancia storage

  ProfileInfoBloc(this.authUseCases) : super(ProfileInfoState()) {

    on<GetUserInfo>((event, emit) async {
      AuthResponse authResponse = await authUseCases.getUserSession.run();

      emit(
        state.copyWith(
          user: authResponse.user
        )
      );
    });

    on<DeleteUser>((event, emit) async {
      try {

        AuthResponse authResponse = await authUseCases.getUserSession.run();

        await authUseCases.deleteUser.run(
          authResponse.user.id!.toString()
        );        
        await storage.clear();
        emit(ProfileInfoState(success: true));        
      } catch (e) {
        print('Error eliminando usuario: $e');
        emit(state.copyWith(success: false));
      }
    });
  }
}