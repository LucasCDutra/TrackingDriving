import 'package:flutter/material.dart';
import 'package:tracking_driving/screens/login_auth/login_screen.dart';
import 'package:tracking_driving/screens/screens.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onTap: togglePages,
      );
    } else {
      return SignUpScreen(
        onTap: togglePages,
      );
    }
  }
}
