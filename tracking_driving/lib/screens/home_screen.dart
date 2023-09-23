import 'package:flutter/material.dart';
import 'package:tracking_driving/controllers/login_controller.dart';
import 'package:tracking_driving/controllers/user_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = LoginController();
    final UserController userController = UserController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => loginController.logoutUser(),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Center(
        child: Text("LOGGED IN - ${userController.user?.email}"),
      ),
    );
  }
}
