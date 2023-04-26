import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  final currentLat = ValueNotifier<double>(0);
  final currentLng = ValueNotifier<double>(0);
  final mapController = ValueNotifier<MapController>(MapController());

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    currentLat.value = position.latitude;
    currentLng.value = position.longitude;
  }

  Future<bool> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('isLogged');
    return true;
  }
}
