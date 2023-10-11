import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:tracking_driving/helpers/preferences_shared/shared_prefs.dart';
import 'package:tracking_driving/screens/offer_ride/screen_offer_ride_review.dart';

import '../helpers/mapbox_handler.dart';

Widget reviewRideFaButton(BuildContext context) {
  return FloatingActionButton.extended(
      icon: const Icon(Icons.local_taxi),
      onPressed: () async {
        LatLng sourceLatLng = getTripLatLngFromSharedPrefs('source');
        LatLng destinationLatLng = getTripLatLngFromSharedPrefs('destination');
        Map modifiedResponse = await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);

        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewRide(modifiedResponse: modifiedResponse)));
      },
      label: const Text('Review Ride'));
}
