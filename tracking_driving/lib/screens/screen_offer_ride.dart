import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:tracking_driving/controller/localization_controller.dart';
import 'package:tracking_driving/main.dart';
import 'package:tracking_driving/screens/offer_ride/screen_offer_ride_prepare.dart';
import 'package:tracking_driving/service/mapbox_service.dart';
import 'package:tracking_driving/helpers/preferences_shared/shared_prefs.dart';

class ScreenOffenRide extends StatefulWidget {
  const ScreenOffenRide({super.key});

  @override
  State<ScreenOffenRide> createState() => _ScreenOffenRideState();
}

class _ScreenOffenRideState extends State<ScreenOffenRide> {
  final locController = Get.put(LocalizationController());
  final SharedPref sharedPref = SharedPref();
  late CameraPosition initialCameraPosition;
  late MapboxMapController mapController;
  late String currentAddress;

  @override
  void initState() {
    super.initState();

    initialCameraPosition =
        CameraPosition(target: locController.userLocation ?? sharedPref.getUserLocation(), zoom: 15);
    currentAddress = getCurrentAddressFromSharedPrefs();
  }

  onMapCreated(MapboxMapController controllerMap) async {
    mapController = controllerMap;
  }

  onStyleLoadedCallback() async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    locController.getUserLocation();

    return SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: size.height * 0.62,
                child: MapboxMap(
                  accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                  initialCameraPosition: initialCameraPosition,
                  onMapCreated: onMapCreated,
                  onStyleLoadedCallback: onStyleLoadedCallback,
                  myLocationEnabled: true,
                  myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                  minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  'Eaeee!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Você está atualemente está aqui:',
                  // style: TextStyle(fontSize: 22),
                ),
                Text(
                  currentAddress,
                  style: const TextStyle(color: Colors.indigoAccent),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrepareRide())),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(18)),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Qual o seu destino?'),
                    ])),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
