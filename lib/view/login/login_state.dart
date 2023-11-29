import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_module/data/user.dart';
import 'package:product_module/services/auth_service.dart';
import 'package:product_module/view/product/product_page.dart';
import 'package:product_module/view/product/product_state.dart';
import 'package:provider/provider.dart';

class LoginPageState extends ChangeNotifier {
  final BuildContext context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _authService = AuthService();
  String? username;
  String? password;

  LoginPageState(this.context) {}

  String? validateIfEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be blank';
    }
    return null;
  }

  Future<void> handleLogin() async {
    if (formKey.currentState!.validate()) {
      //show snackbar to indicate loading
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      // Create an instance of UserLoginRequest
      UserLoginRequest loginRequest = UserLoginRequest(
        username: usernameController.text,
        password: passwordController.text,
      );

      dynamic loginResponse = await _authService.signIn(loginRequest);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (loginResponse != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => ProductPageState(context),
              child: const ProductPage(),
            ),
          ),
        );
      } else {
        //if an error occurs, show snackbar with error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Invalid Credentials.'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }
}
