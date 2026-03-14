import 'package:localdriver/src/domain/repository/AuthRepository.dart';

class DeleteUserUseCase {

  AuthRepository authRepository;

  DeleteUserUseCase(this.authRepository);

  run(String id) => authRepository.delete(id);

}