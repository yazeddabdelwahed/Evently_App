import 'package:evently_c16_online/core/routes/app_route_name.dart';
import 'package:evently_c16_online/main.dart';
import 'package:evently_c16_online/modules/layout/manager/layout_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/provider/app_provider.dart';
import '../../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);

    return Consumer<LayoutProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(64),
                    bottomEnd: Radius.circular(24),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(24),
                              bottomEnd: Radius.circular(360),
                              topEnd: Radius.circular(360),
                              bottomStart: Radius.circular(360),
                            ),
                            child: Image.asset(
                              "assets/images/route.jpg",
                              width: 124,
                              height: 124,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.user.displayName?.toUpperCase() ?? "",
                                style: theme.textTheme.titleLarge!.copyWith(
                                  color: AppColors.lightColor,
                                ),
                              ),
                              Text(
                                provider.user.email ?? "",
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: AppColors.lightColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.locale.language,
                    style: theme.textTheme.titleMedium!.copyWith(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primaryColor)),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      padding: const EdgeInsets.all(4),
                      isExpanded: true,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 18),
                      value: appProvider.locale,
                      items: const [
                        DropdownMenuItem(value: "ar", child: Text("عربي")),
                        DropdownMenuItem(value: "en", child: Text("English")),
                      ],
                      onChanged: (value) {
                        appProvider.changeLanguage(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    context.locale.theme,
                    style: theme.textTheme.titleMedium!.copyWith(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primaryColor)),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      padding: const EdgeInsets.all(4),
                      isExpanded: true,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 18),
                      value: appProvider.themeMode,
                      items: const [
                        DropdownMenuItem(
                            value: ThemeMode.light, child: Text("Light")),
                        DropdownMenuItem(
                            value: ThemeMode.dark, child: Text("Dark")),
                      ],
                      onChanged: (value) {
                        appProvider.changeThemeMode(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      context.goReplace(RouteName.login);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(18)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ))
          ],
        );
      },
    );
  }
}
