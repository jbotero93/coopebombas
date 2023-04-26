import 'dart:convert';

import 'package:coopebombas/common/models/post_model.dart';
import 'package:coopebombas/common/models/user_model.dart';
import 'package:coopebombas/login/external/login_api.dart';
import 'package:coopebombas/main/domain/posts_states_enum.dart';
import 'package:coopebombas/main/external/main_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider with ChangeNotifier {
  final user = ValueNotifier<UserModel?>(null);
  final users = ValueNotifier<List<UserModel>?>(null);
  final posts = ValueNotifier<List<PostModel>?>(null);
  final postsStateEnum = ValueNotifier<PostsStates>(PostsStates.none);
  final refresKey = ValueNotifier<GlobalKey<RefreshIndicatorState>>(
      GlobalKey<RefreshIndicatorState>());

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    final usersJson = prefs.getString('users');
    if (userJson != null && usersJson != null) {
      final userMap = json.decode(userJson);
      final userModel = UserModel.fromJson(userMap);
      List<UserModel> usersModel = (json.decode(usersJson) as List)
          .map((personJson) => UserModel.fromJson(personJson))
          .toList();

      user.value = userModel;
      users.value = usersModel;
      notifyListeners();
      return userModel;
    }
    return null;
  }

  Future<void> getPosts() async {
    postsStateEnum.value = PostsStates.bussy;
    await getUsers();
    List<PostModel>? postList = await MainApi().getPosts();
    if (postList != null && postList.isNotEmpty) {
      postsStateEnum.value = PostsStates.filled;
      posts.value = postList.toList();
    } else if (postList != null && postList.isEmpty) {
      postsStateEnum.value = PostsStates.empty;
    } else {
      postsStateEnum.value = PostsStates.errorRed;
    }
  }

  Future<void> getUsers() async {
    final prefs = await SharedPreferences.getInstance();

    List<UserModel>? usersList = await LoginApi().getUsers();
    if (usersList != null) {
      String usersJson = jsonEncode(usersList.map((e) => e.toJson()).toList());
      await prefs.setString('users', usersJson);
      users.value = usersList;
    }
  }

  UserModel? getUserById({required int userId}) {
    for (final user in users.value!) {
      if (user.id == userId) {
        return user;
      }
    }
    return null;
  }
}
