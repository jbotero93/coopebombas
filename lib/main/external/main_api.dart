import 'dart:convert';

import 'package:coopebombas/api.dart';
import 'package:coopebombas/common/models/post_model.dart';
import 'package:http/http.dart' as http;

class MainApi {
  Future<List<PostModel>?> getPosts() async {
    try {
      var response = await http.get(
        Uri.parse('${Api().baseApiUrl}/posts'),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": 'application/json',
        },
      );
      var body = await jsonDecode(response.body);
      return (body).map<PostModel>((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      return null;
    }
  }
}
