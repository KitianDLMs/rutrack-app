import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:localdriver/src/data/api/ApiConfig.dart';
import 'package:localdriver/src/data/dataSource/remote/services/UsersService.dart';
import 'package:localdriver/src/domain/models/user.dart';
import 'package:localdriver/src/domain/repository/UsersRepository.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';

class UsersRepositoryImpl implements UsersRepository {

  final UsersService usersService;
  final String url = '${ApiConfig.API_PROJECT}';

  UsersRepositoryImpl(this.usersService);

  @override
  Future<Resource<User>> update(int id, User user, File? file) {
    if (file == null) {
      return usersService.update(id, user);
    }
    return usersService.updateImage(id, user, file);
  }
  
  @override
  Future<Resource<User>> updateNotificationToken(int id, String notificationToken) {
    return usersService.updateNotificationToken(id, notificationToken);
  }

  @override
  Future<void> delete(String id) async {
    final response = await http.delete(
      Uri.parse('$url/users/delete/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar usuario');
    }
  }
}