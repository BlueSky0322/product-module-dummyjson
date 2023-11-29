import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? userId;
  String? token;

  void setUserData(String id, String token) {
    userId = id;
    token = token;
    notifyListeners();
  }
}
