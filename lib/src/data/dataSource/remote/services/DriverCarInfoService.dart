import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localdriver/src/data/api/ApiConfig.dart';
import 'package:localdriver/src/domain/models/DriverCarInfo.dart';
import 'package:localdriver/src/domain/utils/ListToString.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';

class DriverCarInfoService {

  Future<Resource<bool>> create(DriverCarInfo driverCarInfo) async {
     try {
      print(driverCarInfo.idDriver);
      Uri url = Uri.https(ApiConfig.API_PROJECT, '/driver-car-info');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode(driverCarInfo);
      print('bodyxxx $body');
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
      
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<DriverCarInfo>> getDriverCarInfo(int idDriver) async {
    try {
      Uri url = Uri.https(ApiConfig.API_PROJECT, '/driver-car-info/$idDriver');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      final response = await http.get(url, headers: headers);
      print('responsexxx $response');
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        DriverCarInfo driverCarInfo = DriverCarInfo.fromJson(data);
        return Success(driverCarInfo);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
      
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

}