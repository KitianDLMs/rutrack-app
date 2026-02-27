import 'dart:io';

import 'package:localdriver/src/domain/models/user.dart';
import 'package:localdriver/src/domain/repository/UsersRepository.dart';

class UpdateUserUseCase {

  UsersRepository usersRepository;

  UpdateUserUseCase(this.usersRepository);

  run(int id, User user, File? file) => usersRepository.update(id, user, file);

}