import 'package:localdriver/src/domain/useCases/auth/DeleteUserUseCase.dart';
import 'package:localdriver/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:localdriver/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:localdriver/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:localdriver/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:localdriver/src/domain/useCases/auth/SaveUserSessionUseCase.dart';

class AuthUseCases {

  LoginUseCase login;
  RegisterUseCase register;
  SaveUserSessionUseCase saveUserSession;
  GetUserSessionUseCase getUserSession;
  LogoutUseCase logout;
  DeleteUserUseCase deleteUser;

  AuthUseCases({
    required this.login,
    required this.register,
    required this.saveUserSession,
    required this.getUserSession,
    required this.logout,
    required this.deleteUser,
  });

}