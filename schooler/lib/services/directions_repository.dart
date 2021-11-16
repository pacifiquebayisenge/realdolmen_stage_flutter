import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:schooler/services/directions_model.dart';
import 'package:schooler/services/env.dart';

class DirectionsRepository {

  static const _baseUrl = 'https://maps.googleapis.com/maps/directions/json?';

  final Dio _dio;

  DirectionsRepository({ Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({ required LatLng origin, required LatLng destination}) async {

    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
      'origin': '${origin.latitude}, ${origin.longitude}',
      'destination': '${destination.latitude}, ${destination.longitude}',
      'key': googleAPIKey,
      }
    );

    // response succes
    if(response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }

    return null;

  }
}