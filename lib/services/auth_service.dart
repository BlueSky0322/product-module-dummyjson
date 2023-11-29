import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:product_module/const.dart';
import 'package:product_module/data/user.dart';

class AuthService {
  final client = Client();

  Future<Map<String, dynamic>?> signIn(UserLoginRequest loginRequest) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final jsonData = json.encode(loginRequest.toJson());

      final response = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        Map<String, dynamic> authedUserData = {
          "id": responseData['id'] as int,
          "token": responseData['token'],
        };
        return authedUserData;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      log('Error logging in: $error');
      return null;
    }
  }
}
