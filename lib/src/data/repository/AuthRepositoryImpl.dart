import 'package:localdriver/src/data/dataSource/local/SharefPref.dart';
import 'package:localdriver/src/data/dataSource/remote/services/AuthService.dart';
import 'package:localdriver/src/domain/models/AuthResponse.dart';
import 'package:localdriver/src/domain/models/user.dart';
import 'package:localdriver/src/domain/repository/AuthRepository.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';

class AuthRepositoryImpl implements AuthRepository {
  
  AuthService authService;
  SharefPref sharefPref;

  AuthRepositoryImpl(this.authService, this.sharefPref);

  @override
  Future<Resource<AuthResponse>> login(String email, String password) {
    return authService.login(email, password);
  }

  @override
  Future<Resource<AuthResponse>> register(User user) {
    return authService.register(user);
  }
  
  @override
  Future<AuthResponse?> getUserSession() async {
    final data = await sharefPref.read('user');
    if (data != null) {
      AuthResponse authResponse = AuthResponse.fromJson(data);
      return authResponse;
    }
    return null;
  }
  
  @override
  Future<void> saveUserSession(AuthResponse authResponse) async {
    sharefPref.save('user', authResponse.toJson());
  }
  
  @override
  Future<bool> logout() async {
    return await sharefPref.remove('user');
  }
  
  @override
  Future<void> delete(String id) async {
    try {
      // 1. Llamar al servicio de eliminación en el backend (si existe)
      await authService.delete(id);  // Aquí se llama al método deleteUser de AuthService

      // 2. Eliminar los datos de sesión localmente
      await sharefPref.remove('user');  // Elimina la información de usuario almacenada

      // Aquí también podrías agregar otras operaciones, como eliminar tokens o realizar limpieza adicional.
    } catch (e) {
      throw Exception('Error al eliminar usuario: $e');
    }
  }

}