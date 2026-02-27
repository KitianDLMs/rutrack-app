import 'dart:convert';
import 'dart:io';
import 'package:localdriver/src/domain/models/AuthResponse.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

class AppleSignInService {
  static String clientId = 'com.echnelapp.flsigninapple';
  static String redirectUri = 'https://localdriver.onrender.com/auth/apple-callback';

  static Future<AuthResponse?> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: clientId,
          redirectUri: Uri.parse(redirectUri),
        ),
      );

      final uri = Uri.parse(
        'https://localdriver.onrender.com/auth/apple',
      );

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'code': credential.authorizationCode,
          'firstName': credential.givenName,
          'lastName': credential.familyName,
          'useBundleId': Platform.isIOS,
        }),
      );

      final data = jsonDecode(response.body);
      if (data['user'] != null) {
        print("dataok ${data}");
        return AuthResponse.fromJson(data);
      }

      return null;

    } catch (e) {
      print('Error en Apple Sign-In: $e');
      return null;
    }
  }
}
