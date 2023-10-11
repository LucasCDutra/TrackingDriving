import 'dart:convert';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:tracking_driving/main.dart';
import 'package:tracking_driving/service/mapbox_service.dart';
import 'package:tracking_driving/helpers/preferences_shared/shared_prefs.dart';

class LocalizationController extends GetxController {
  final mapBoxService = MapBoxService();
  final SharedPref sharedPref = SharedPref();

  LatLng? userLocation;

  void initializeLocationsAndSave() async {
    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) serviceEnabled = await location.requestService();
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) await location.requestPermission();

    LocationData locationData = await location.getLocation();
    LatLng currentLatLng = LatLng(locationData.latitude!, locationData.longitude!);

    userLocation = currentLatLng;
    sharedPref.setUserLocation(currentLatLng);
    update();
    print('lat ${userLocation?.latitude}');
  }

  void getUserLocation() {
    userLocation = sharedPref.getUserLocation();
    update();
  }

  void getDrivingNavigation() async {
    LatLng source = const LatLng(-23.0253167, -46.731578799999994);
    LatLng destination = const LatLng(-23.002315, -46.826073);

    final response = await mapBoxService.getDrivingRoutesMapbox(source, destination);

    Map geometry = response['routes'][0]['geometry'];
    num duration = response['routes'][0]['duration'];
    num distance = response['routes'][0]['distance'];

    Map modifiedResponse = {'geometry': geometry, 'duration': duration, 'distance': distance};

    saveDirectionsAPIResponse(json.encode(modifiedResponse));
  }

  void saveDirectionsAPIResponse(String response) {
    sharedPreferences.setString('routeNavigation', response);
  }
}
