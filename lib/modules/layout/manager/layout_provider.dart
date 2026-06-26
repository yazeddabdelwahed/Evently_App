import 'package:evently_c16_online/core/models/event_model.dart';
import 'package:evently_c16_online/modules/layout/pages/home_screen.dart';
import 'package:evently_c16_online/modules/layout/pages/love_screen.dart';
import 'package:evently_c16_online/modules/layout/pages/map_screen.dart';
import 'package:evently_c16_online/modules/layout/pages/profile_screen.dart';
import 'package:evently_c16_online/modules/layout/services/layout_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LayoutProvider extends ChangeNotifier {

  List<Widget> screens = [
    HomeScreen(),
    MapScreen(),
    LoveScreen(),
    ProfileScreen(),
  ];
  List<EventModel> events = [];

  User get user => FirebaseAuth.instance.currentUser!;

  int navIndex = 0;
  int tabIndex = 0;

  void onTabIndexChange(int index) {
    tabIndex = index;
    notifyListeners();
  }

  void onNavTap(int index) {
    navIndex = index;
    notifyListeners();
  }

  Future<void> toggleFavorite(EventModel event) async {
    await LayoutServices.toggleFavorite(event);
    notifyListeners();
  }

  //
  // Future<void> getEvents(){
  //
  // }
}
