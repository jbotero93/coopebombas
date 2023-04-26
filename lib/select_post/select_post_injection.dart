import 'package:coopebombas/common/models/post_model.dart';
import 'package:coopebombas/common/models/user_model.dart';
import 'package:coopebombas/select_post/domain/select_post_provider.dart';
import 'package:coopebombas/select_post/interface/select_post_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectPostInjection {
  SelectPostInjection._();

  static Widget injection(
      {required PostModel post,
      required UserModel user,
      required UserModel postUser}) {
    return ListenableProvider(
      create: (context) =>
          SelectPostProvider()..getComments(id: (post.id ?? 0)),
      child: SelectPostPage(
        post: post,
        user: user,
        postUser: postUser,
      ),
    );
  }
}
