import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'dart:developer' as developer;

import 'package:localdriver/src/domain/models/AuthResponse.dart';

class GoogleSignInService {

  static GoogleSignIn _buildGoogleSignIn() {
    if (Platform.isAndroid) {
      return GoogleSignIn(
        scopes: ['email', 'profile'],
        serverClientId:
            '538000452693-1v6jbd9oardl19hg1dmtsbefaea9onm3.apps.googleusercontent.com',
            forceCodeForRefreshToken: true,
      );
    }

    return GoogleSignIn(
      scopes: ['email', 'profile'],
    );
  }

  static final GoogleSignIn _googleSignIn = _buildGoogleSignIn();

  static Future<AuthResponse?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return null;

      final auth = await account.authentication;
      final googleToken = auth.idToken!;

      final url = Uri(
        scheme: 'https',
        host: 'localdriver.onrender.com',
        path: '/auth/google',
      );

      final response = await post(
        url,
        body: {'token': googleToken},
      );


      final data = jsonDecode(response.body);      
      
      if (data['ok'] == true) {        
        return AuthResponse.fromJson(data['dbUser']);
      }

      return null;
    } catch (e) {
      print('Error en Google Sign-In: $e');
      return null;
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
