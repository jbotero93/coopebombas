import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coopebombas/login/login_injection.dart';
import 'package:coopebombas/main/interface/main_page.dart';
import 'package:coopebombas/main/main_injection.dart';
import 'package:coopebombas/splash/domain/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvier = Provider.of<SplashProvider>(context);
    return ValueListenableBuilder(
      valueListenable: splashProvier.isLogged,
      builder: (context, isLogged, snapshot) {
        return AnimatedSplashScreen(
          splash: 'assets/logo.png',
          nextScreen: isLogged == true
              ? MainInjection.injection()
              : LoginInjection.injection(),
          splashTransition: SplashTransition.slideTransition,
          pageTransitionType: PageTransitionType.leftToRight,
        );
      },
    );
  }
}
