import 'package:flutter/material.dart';

class AuthedUser with ChangeNotifier {
  int? id;
  String? token;

  AuthedUser({
    this.id,
    this.token,
  });

  factory AuthedUser.fromJson(Map<String, dynamic> json) {
    return AuthedUser(
      id: json['id'],
      token: json['token'],
    );
  }

  void setUserData(int id, String token) {
    this.id = id;
    this.token = token;
    notifyListeners();
  }
}

class UserLoginRequest {
  final String username;
  final String password;

  UserLoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
