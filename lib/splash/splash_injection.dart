import 'package:coopebombas/splash/domain/splash_provider.dart';
import 'package:coopebombas/splash/interface/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashInjection {
  SplashInjection._();

  static Widget injection() {
    return ListenableProvider(
      create: (context) => SplashProvider()..checkSession(),
      child: const SplashPage(),
    );
  }
}
