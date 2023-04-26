import 'package:coopebombas/colors.dart';
import 'package:coopebombas/login/domain/login_provider.dart';
import 'package:coopebombas/login/domain/login_state_enum.dart';
import 'package:coopebombas/main/main_injection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:route_animation_helper/route_animation_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                SizedBox(
                  width: 200,
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
                const SizedBox(height: 80),
                Center(
                  child: Text(
                    'Inicia Sesión',
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: loginProvider.emailController.value,
                        decoration: const InputDecoration(
                          hintText: 'Correo electrónico',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: loginProvider.loginStateEnum,
                        builder: (context, loginState, snapshot) {
                          return Column(
                            children: [
                              loginState != LoginState.none
                                  ? const SizedBox(height: 60)
                                  : Container(),
                              loginState == LoginState.none
                                  ? Container()
                                  : loginState == LoginState.errorInfo
                                      ? Text(
                                          'El email o nombre de usuario son incorrectos',
                                          style: GoogleFonts.poppins(),
                                        )
                                      : loginState == LoginState.errorRed
                                          ? Text(
                                              'No eres tú, somos nosotros. Vuelve más tarde',
                                              style: GoogleFonts.poppins(),
                                            )
                                          : loginState == LoginState.bussy
                                              ? const CircularProgressIndicator()
                                              : loginState ==
                                                      LoginState.emptyInfo
                                                  ? Text(
                                                      'Debes llenar los datos primero',
                                                      style:
                                                          GoogleFonts.poppins(),
                                                    )
                                                  : Container(),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 60),
                      InkWell(
                        onTap: () {
                          loginProvider.login().then(
                            (value) {
                              if (value == true) {
                                Navigator.of(context).pushReplacement(
                                  RouteAnimationHelper.createRoute(
                                    buildContext: context,
                                    destination: MainInjection.injection(),
                                    animType: AnimType.slideStart,
                                  ),
                                );
                              }
                            },
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 80,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: CooColors().cooBlue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Iniciar',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
