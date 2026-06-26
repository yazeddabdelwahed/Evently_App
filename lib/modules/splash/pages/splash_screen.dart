import 'package:animate_do/animate_do.dart';
import 'package:evently_c16_online/core/routes/app_route_name.dart';
import 'package:evently_c16_online/core/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
              child: FadeInDownBig(
                  duration: const Duration(seconds: 2),
                  child: Hero(
                      tag: "logo",
                      child: Image.asset("assets/logo/app_logo.png")))),
          FadeInUpBig(
            duration: const Duration(seconds: 2),
            child: Hero(
              tag: "appName",
              child: Material(
                elevation: 0,
                color: Colors.transparent,
                child: Text(
                  "Evently",
                  style: GoogleFonts.jockeyOne(
                      color: AppColors.primaryColor, fontSize: 36),
                ),
              ),
            ),
          ),
          const Spacer(),
          FadeInUpBig(
              onFinish: (direction) {
                if (FirebaseAuth.instance.currentUser != null) {
                  Navigator.pushReplacementNamed(context, RouteName.layout);
                } else {
                  Navigator.pushReplacementNamed(context, RouteName.onBoarding);
                }
              },
              delay: const Duration(seconds: 2),
              child: Image.asset("assets/logo/route_logo.png")),
        ],
      ),
    );
  }
}
