import 'dart:convert';

import 'package:coopebombas/api.dart';
import 'package:coopebombas/common/models/user_model.dart';
import 'package:coopebombas/login/domain/login_state_enum.dart';
import 'package:coopebombas/login/external/login_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  final emailController =
      ValueNotifier<TextEditingController>(TextEditingController());
  final loginStateEnum = ValueNotifier<LoginState>(LoginState.none);

  Future<bool?> login() async {
    if (emailController.value.text.isNotEmpty) {
      loginStateEnum.value = LoginState.bussy;
      List<UserModel>? users = await LoginApi().getUsers();
      if (users == null) {
        loginStateEnum.value = LoginState.errorRed;
      } else {
        UserModel? foundUser = users.firstWhere(
          (element) =>
              element.email!.toLowerCase() ==
              emailController.value.text.toLowerCase(),
          orElse: () => UserModel(),
        );

        final prefs = await SharedPreferences.getInstance();

        if (foundUser.email != null && foundUser.email!.isNotEmpty) {
          final userMap = foundUser.toJson();
          final userJson = jsonEncode(userMap);
          String usersJson = jsonEncode(users.map((e) => e.toJson()).toList());

          await prefs.setString('user', userJson);
          await prefs.setString('users', usersJson);
          await prefs.setBool('isLogged', true);
          loginStateEnum.value = LoginState.logged;
          return true;
        } else {
          loginStateEnum.value = LoginState.errorInfo;
        }
      }
    } else {
      loginStateEnum.value = LoginState.emptyInfo;
    }
  }
}
