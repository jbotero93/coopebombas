import 'dart:convert';

import 'package:coopebombas/api.dart';
import 'package:coopebombas/common/models/post_model.dart';
import 'package:http/http.dart' as http;

class EditPostApi {
  Future<PostModel?> getPost({required int id}) async {
    try {
      var response = await http.get(
        Uri.parse('${Api().baseApiUrl}/posts/$id'),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": 'application/json',
        },
      );
      var body = await jsonDecode(response.body);
      return PostModel.fromJson(body);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updatePost({required PostModel post}) async {
    try {
      var response = await http.put(
        Uri.parse('${Api().baseApiUrl}/posts/${post.id}'),
        body: jsonEncode(post.toJson()),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": 'application/json',
        },
      );
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      return false;
    }
  }
}
