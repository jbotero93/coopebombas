import 'package:coopebombas/edit_post/domain/edit_post_provider.dart';
import 'package:coopebombas/edit_post/interface/edit_post_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPostInjection {
  EditPostInjection._();

  static Widget injection({required int id}) {
    return ListenableProvider(
      create: (context) => EditPostProvider()..getPost(id: id),
      child: EditPostPage(),
    );
  }
}
