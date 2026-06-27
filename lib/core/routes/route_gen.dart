import 'package:evently_c16_online/core/routes/app_route_name.dart';
import 'package:evently_c16_online/modules/auth/pages/forget_password_screen.dart';
import 'package:evently_c16_online/modules/auth/pages/login_screen.dart';
import 'package:evently_c16_online/modules/auth/pages/register_screen.dart';
import 'package:evently_c16_online/modules/events/edit_event/edit_event.dart';
import 'package:evently_c16_online/modules/events/event_details/event_details.dart';
import 'package:evently_c16_online/modules/events/pages/add_event_screen.dart';
import 'package:evently_c16_online/modules/layout/pages/layout_screen.dart';
import 'package:evently_c16_online/modules/onboarding/pages/onboarding_screen.dart';
import 'package:evently_c16_online/modules/splash/pages/splash_screen.dart';
import 'package:flutter/material.dart';

import '../models/event_model.dart';

class RouteGen {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SplashScreen();
          },
        );
      case RouteName.onBoarding:
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) {
            return OnboardingScreen();
          },
        );
      case RouteName.login:
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) {
            return LoginScreen();
          },
        );
      case RouteName.register:
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) {
            return RegisterScreen();
          },
        );
      case RouteName.forgetPassword:
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) {
            return ForgetPasswordScreen();
          },
        );
      case RouteName.layout:
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) {
            return LayoutScreen();
          },
        );
      case RouteName.addEvent:
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) {
            return AddEventScreen();
          },
        );
      case RouteName.eventDetails:
        {
          var event = settings.arguments as EventModel;
          return MaterialPageRoute(
              builder: (_) => EventDetails(eventModel: event));
        }
      case RouteName.editEvent:
        {
          var event = settings.arguments as EventModel;
          return MaterialPageRoute(
              builder: (_) => EditEvent(eventModel: event));
        }
      default:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return NotFoundScreen();
          },
        );
    }
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
