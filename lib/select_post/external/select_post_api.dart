import 'dart:convert';
import 'package:coopebombas/api.dart';
import 'package:http/http.dart' as http;
import 'package:coopebombas/select_post/domain/comment_model.dart';

class SelectPostApi {
  Future<List<CommentModel>?> getComments({required int id}) async {
    try {
      var response = await http.get(
        Uri.parse('${Api().baseApiUrl}/comments?postId=$id'),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": 'application/json',
        },
      );
      var body = await jsonDecode(response.body);
      return (body).map<CommentModel>((e) => CommentModel.fromJson(e)).toList();
    } catch (e) {
      return null;
    }
  }
}
