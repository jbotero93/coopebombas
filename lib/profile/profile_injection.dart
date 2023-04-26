import 'package:coopebombas/common/models/user_model.dart';
import 'package:coopebombas/profile/domain/profile_provider.dart';
import 'package:coopebombas/profile/interface/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileInjection {
  ProfileInjection._();

  static Widget injection({required UserModel user}) {
    return ListenableProvider(
      create: (context) => ProfileProvider()..getCurrentLocation(),
      child: ProfilePage(user: user),
    );
  }
}
