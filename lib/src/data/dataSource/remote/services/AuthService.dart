import 'dart:convert';

import 'package:localdriver/src/data/api/ApiConfig.dart';
import 'package:http/http.dart' as http;
import 'package:localdriver/src/domain/models/AuthResponse.dart';
import 'package:localdriver/src/domain/models/user.dart';
import 'package:localdriver/src/domain/utils/ListToString.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';

class AuthService {

  Future<Resource<AuthResponse>> login(String email, String password) async {
    try {
      Uri url = Uri.https(ApiConfig.API_PROJECT, '/auth/login');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode({
        'email': email,
        'password': password
      });
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        return Success(authResponse);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
      
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

   Future<Resource<AuthResponse>> register(User user) async {
    try {      
      Uri url = Uri.https(ApiConfig.API_PROJECT, '/auth/register');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode(user.toJson());
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);        
        return Success(authResponse);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
      
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<String>> delete(String userId) async {
    try {      
      Uri url = Uri.https(ApiConfig.API_PROJECT, '/auth/delete-account');
      Map<String, String> headers = {
        'Content-Type': 'application/json'
      };

      final response = await http.delete(url, headers: headers);

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return Success('Cuenta eliminada correctamente');
      } else {
        return ErrorData(data['message'] ?? 'Error al eliminar la cuenta');
      }
    } catch (e) {
      return ErrorData(e.toString());
    }
  }
}