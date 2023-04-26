import 'package:coopebombas/colors.dart';
import 'package:coopebombas/common/models/user_model.dart';
import 'package:coopebombas/profile/domain/profile_provider.dart';
import 'package:coopebombas/splash/splash_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:route_animation_helper/route_animation_helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: CooColors().cooBlue,
      appBar: AppBar(
        iconTheme: IconThemeData(color: CooColors().cooBlue),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Perfil',
          style: GoogleFonts.poppins(
            color: CooColors().cooBlue,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Icon(
                Icons.person,
                color: Colors.white,
                size: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                user.name ?? '',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                user.address?.city ?? '',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              Text(
                'St. ${user.address?.street ?? ''} ${user.address?.suite ?? ''}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              Text(
                'Zip code ${user.address?.zipcode ?? ''}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  color: Colors.white,
                ),
              ),
              Text(
                user.email ?? '',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              Text(
                user.phone ?? '',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlutterMap(
                  mapController: profileProvider.mapController.value,
                  options: MapOptions(
                    center: LatLng(
                      double.parse(
                        user.address?.geo?.lat ?? '30',
                      ),
                      double.parse(
                        user.address?.geo?.lng ?? '30',
                      ),
                    ),
                    zoom: 6,
                    maxZoom: 15,
                  ),
                  children: <Widget>[
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            double.parse(
                              user.address?.geo?.lat ?? '30',
                            ),
                            double.parse(
                              user.address?.geo?.lng ?? '30',
                            ),
                          ),
                          builder: (context) {
                            return Container(
                              child: Icon(
                                Icons.person_pin_circle_rounded,
                                size: 40,
                              ),
                            );
                          },
                        ),
                        Marker(
                          point: LatLng(
                            profileProvider.currentLat.value,
                            profileProvider.currentLng.value,
                          ),
                          builder: (context) {
                            return Container(
                              child: Icon(
                                Icons.person_pin_circle_rounded,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  profileProvider.mapController.value.move(
                      LatLng(profileProvider.currentLat.value,
                          profileProvider.currentLng.value),
                      10);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 80,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Centrar',
                        style: GoogleFonts.poppins(
                          color: CooColors().cooBlue,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: CooColors().cooBlue,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () async {
                  const dialogChannel =
                      const MethodChannel('samples.flutter.dev/dialog');
                  try {
                    bool result =
                        await dialogChannel.invokeMethod('showDialog', {
                      'title': 'Confirmación',
                      'message':
                          '¿Está seguro de que desea realizar esta acción?',
                      'positiveButton': 'Aceptar',
                      'negativeButton': 'Cancelar',
                    });
                    if (result) {
                      profileProvider.logOut().then(
                            (value) => Navigator.of(context).pushReplacement(
                              RouteAnimationHelper.createRoute(
                                buildContext: context,
                                destination: SplashInjection.injection(),
                                animType: AnimType.slideStart,
                              ),
                            ),
                          );
                    }
                  } on PlatformException catch (e) {
                    print(e.message);
                  }
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
                        'Cerrar sesión',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
