import 'dart:convert';

import 'package:coopebombas/api.dart';
import 'package:coopebombas/common/models/user_model.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  Future<List<UserModel>?> getUsers() async {
    try {
      var response = await http.get(
        Uri.parse('${Api().baseApiUrl}/users'),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": 'application/json',
        },
      );
      var body = await jsonDecode(response.body);
      return (body).map<UserModel>((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      return null;
    }
  }
}
