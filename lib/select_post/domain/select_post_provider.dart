import 'package:coopebombas/select_post/domain/comment_model.dart';
import 'package:coopebombas/select_post/domain/comment_state_enum.dart';
import 'package:coopebombas/select_post/external/select_post_api.dart';
import 'package:flutter/material.dart';

class SelectPostProvider with ChangeNotifier {
  final commentStateEnum =
      ValueNotifier<CommentStateEnum>(CommentStateEnum.none);
  final comments = ValueNotifier<List<CommentModel>?>(null);

  Future<void> getComments({required int id}) async {
    commentStateEnum.value = CommentStateEnum.bussy;
    comments.value = await SelectPostApi().getComments(id: id);
    if (comments.value != null && comments.value!.isNotEmpty) {
      commentStateEnum.value = CommentStateEnum.filled;
    } else if (comments.value != null && comments.value!.isEmpty) {
      commentStateEnum.value = CommentStateEnum.empty;
    } else {
      commentStateEnum.value = CommentStateEnum.errorRed;
    }
  }
}
