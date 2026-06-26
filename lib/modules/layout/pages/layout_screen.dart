import 'package:evently_c16_online/core/routes/app_route_name.dart';
import 'package:evently_c16_online/core/theme/app_colors.dart';
import 'package:evently_c16_online/modules/layout/manager/layout_provider.dart';
import 'package:evently_c16_online/modules/layout/services/layout_services.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LayoutProvider(),
      child: Consumer<LayoutProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: provider.screens[provider.navIndex],
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.addEvent);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: provider.onNavTap,
                currentIndex: provider.navIndex,
                fixedColor: Colors.white,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Iconsax.home_1_outline),
                      activeIcon: Icon(Iconsax.home_1_bold),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Iconsax.location_outline),
                      activeIcon: Icon(Iconsax.location_bold),
                      label: "Map"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border_rounded),
                      activeIcon: Icon(Icons.favorite),
                      label: "Love"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_rounded),
                      activeIcon: Icon(Icons.person_rounded),
                      label: "Profile"),
                ]),
          );
        },
      ),
    );
  }
}
