import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';

class MapBoxService {
  String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
  String navType = 'driving';

  Dio dio = Dio();

  Future getDrivingRoutesMapbox(LatLng source, LatLng destination) async {
    print('access -> $accessToken');

    String url =
        '$baseUrl/$navType/${source.longitude}%2C${source.latitude}%3B${destination.longitude}%2C${source.latitude}?alternatives=true&geometries=geojson&language=pt&overview=full&steps=true&access_token=$accessToken';

    try {
      dio.options.contentType = Headers.jsonContentType;
      final responseData = await dio.get(url);

      print(responseData.data);
      return responseData.data;
    } catch (e) {
      print('Error: $e');
    }
  }
}
