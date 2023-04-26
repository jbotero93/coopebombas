import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider with ChangeNotifier {
//Variable que escucha si el usuario está loggeado
  final isLogged = ValueNotifier<bool>(false);

//Revisar si el usuario está loggeado y ponerlo en la variable que escucha
  Future<void> checkSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? getLogged = prefs.getBool('isLogged');
    isLogged.value = getLogged ?? false;
  }
}
