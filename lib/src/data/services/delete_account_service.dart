import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localdriver/src/data/api/ApiConfig.dart';

class DeleteAccountService {

  Future<String> token;

  DeleteAccountService(this.token);

  Future<bool> deleteAccount() async {

    try {

      Uri url = Uri.https(
        ApiConfig.API_PROJECT,
        '/auth/delete-account'
      );

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await token
        },
      );

      final data = jsonDecode(response.body);

      return response.statusCode == 200 && data['ok'] == true;

    } catch (e) {
      print('Error eliminando cuenta: $e');
      return false;
    }
  }
}