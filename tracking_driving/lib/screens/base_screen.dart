import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tracking_driving/components/bottom_bar_custom.dart';
import 'package:tracking_driving/controller/base_controller.dart';
import 'package:tracking_driving/controller/localization_controller.dart';
import 'package:tracking_driving/controller/login_controller.dart';
import 'package:tracking_driving/controller/user_controller.dart';
import 'package:tracking_driving/screens/screen_messages.dart';
import 'package:tracking_driving/screens/screen_offer_ride.dart';
import 'package:tracking_driving/screens/screen_perfil.dart';
import 'package:tracking_driving/screens/screen_search_car.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = LoginController();
    final LocalizationController localizationController = LocalizationController();
    final BaseController baseController = BaseController();

    localizationController.initializeLocationsAndSave();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'VIPTrack',
            style: TextStyle(color: Colors.white),
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () => loginController.logoutUser(),
        //     icon: const Icon(Icons.logout_outlined),
        //   ),
        // ],
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: BottomBarCustom(
            controller: baseController,
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: baseController.pageController,
        children: const [
          ScreenSearchCar(),
          ScreenOffenRide(),
          ScreenMessage(),
          ScreenPerfil(),
        ],
      ),
    );
  }
}
