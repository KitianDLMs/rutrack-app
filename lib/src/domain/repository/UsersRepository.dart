import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:localdriver/src/domain/models/user.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UsersRepository {

  Future<Resource<User>> update(int id, User user, File? file);
  Future<Resource<User>> updateNotificationToken(int id, String notificationToken);
 Future<void> delete(String id) async {
    final String url = 'https://yourapiurl.com';  // Define la URL base de la API
    final String? sessionToken = await _getSessionToken(); // Obtén el sessionToken desde donde lo tengas guardado

    if (sessionToken == null) {
      throw Exception('No hay token de sesión disponible');
    }

    final response = await http.delete(
      Uri.parse('$url/users/delete/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $sessionToken',  // Asegúrate de pasar el token correctamente
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar usuario');
    }
  }

  // Método para obtener el sessionToken desde SharedPreferences o cualquier fuente que uses
  Future<String?> _getSessionToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_token'); // Ajusta el nombre según cómo guardes el token
  }
}