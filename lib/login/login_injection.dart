import 'package:coopebombas/login/domain/login_provider.dart';
import 'package:coopebombas/login/interface/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginInjection {
  LoginInjection._();

  static Widget injection() {
    return ListenableProvider(
      create: (context) => LoginProvider(),
      child: LoginPage(),
    );
  }
}
