import 'package:coopebombas/main/domain/main_provider.dart';
import 'package:coopebombas/main/interface/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainInjection {
  MainInjection._();

  static Widget injection() {
    return ListenableProvider(
      create: (context) => MainProvider()
        ..getUser()
        ..getPosts(),
      child: MainPage(),
    );
  }
}
