import 'package:coopebombas/common/models/post_model.dart';
import 'package:coopebombas/edit_post/domain/edit_post_states_enum.dart';
import 'package:coopebombas/edit_post/external/edit_post_api.dart';
import 'package:flutter/material.dart';

class EditPostProvider with ChangeNotifier {
  final editPostState =
      ValueNotifier<EditPostStatesEnum>(EditPostStatesEnum.none);
  final post = ValueNotifier<PostModel?>(null);

  final titleController =
      ValueNotifier<TextEditingController>(TextEditingController());

  final bodyController =
      ValueNotifier<TextEditingController>(TextEditingController());

  Future<void> getPost({required int id}) async {
    editPostState.value = EditPostStatesEnum.bussy;
    post.value = await EditPostApi().getPost(id: id);
    if (post.value != null) {
      editPostState.value = EditPostStatesEnum.loaded;
      titleController.value.text = post.value!.title ?? '';
      bodyController.value.text = post.value!.body ?? '';
    } else {
      editPostState.value = EditPostStatesEnum.error;
    }
  }

  Future<bool> updatePost({required PostModel post}) async {
    post.title = titleController.value.text;
    post.body = bodyController.value.text;
    editPostState.value = EditPostStatesEnum.bussy;
    return await EditPostApi().updatePost(post: post);
  }
}
