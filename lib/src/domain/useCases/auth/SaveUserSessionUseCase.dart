import 'package:localdriver/src/domain/models/AuthResponse.dart';
import 'package:localdriver/src/domain/repository/AuthRepository.dart';

class SaveUserSessionUseCase {

  AuthRepository authRepository;

  SaveUserSessionUseCase(this.authRepository);

  run(AuthResponse authResponse) => authRepository.saveUserSession(authResponse);

}