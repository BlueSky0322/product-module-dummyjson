import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_module/components/ui/custom_text_field.dart';
import 'package:product_module/view/login/login_state.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LoginPageState>(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: GoogleFonts.outfit(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Enter username and password to continue.",
                      style: GoogleFonts.outfit(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: state.formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  validator: (value) =>
                                      state.validateIfEmpty(value),
                                  onChanged: (value) => state.username = value,
                                  labelText: "Username",
                                  hintText: "Enter your username",
                                  controller: state.usernameController,
                                ),
                                _gap(),
                                CustomTextField(
                                  validator: (value) =>
                                      state.validateIfEmpty(value),
                                  onChanged: (value) => state.password = value,
                                  labelText: "Password",
                                  hintText: "Enter your password",
                                  controller: state.passwordController,
                                ),
                                _gap(),
                                _gap(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          state.handleLogin();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue.shade900,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 15),
                                        ),
                                        child: Text(
                                          "Sign in",
                                          style: GoogleFonts.outfit(
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _gap() => const SizedBox(height: 16);
