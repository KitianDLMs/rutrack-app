import 'package:localdriver/src/domain/repository/AuthRepository.dart';

class LogoutUseCase {

  AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  run() => authRepository.logout();

}