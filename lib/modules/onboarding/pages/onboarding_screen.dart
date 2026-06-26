import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_c16_online/core/provider/app_provider.dart';
import 'package:evently_c16_online/core/routes/app_route_name.dart';
import 'package:evently_c16_online/core/widgets/custom_btn.dart';
import 'package:evently_c16_online/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:evently_c16_online/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    var provider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "logo",
                    child: Image.asset(
                      "assets/logo/app_logo.png",
                      width: 50,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Hero(
                    tag: "appName",
                    child: Material(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Text(
                        localization!.title,
                        style: GoogleFonts.jockeyOne(
                            color: AppColors.primaryColor, fontSize: 36),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  )
                ],
              ),
              const Spacer(),
              Expanded(
                flex: 5,
                child: Center(
                    child: ZoomIn(
                        child:
                            Image.asset("assets/images/onboarding_light.png"))),
              ),
              const Spacer(),
              Text(
                localization.onBoardingTitle,
                style: TextStyle(
                    fontSize: 26,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                localization.onBoardingDes,
                style: theme.textTheme.bodyMedium,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localization.language,
                      style: TextStyle(
                          fontSize: 26,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    AnimatedToggleSwitch<String>.rolling(
                      indicatorIconScale: 1.2,
                      current: provider.locale,
                      values: const ["en", "ar"],
                      iconList: [
                        Image.asset("assets/icons/en.png"),
                        Image.asset("assets/icons/ar.png"),
                      ],
                      onChanged: (value) {
                        provider.changeLanguage(value);
                      },
                      style: ToggleStyle(
                        backgroundColor: Colors.transparent,
                        indicatorColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                      ),
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localization.theme,
                      style: TextStyle(
                          fontSize: 26,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    AnimatedToggleSwitch<ThemeMode>.rolling(
                      current: provider.themeMode,
                      values: const [ThemeMode.light, ThemeMode.dark],
                      onChanged: (value) {
                        provider.changeThemeMode(value);
                      },
                      iconList: [
                        Image.asset("assets/icons/light.png"),
                        Image.asset("assets/icons/dark.png",
                            color: provider.themeMode == ThemeMode.dark
                                ? Colors.white
                                : null),
                      ],
                      indicatorIconScale: 1.2,
                      style: ToggleStyle(
                        backgroundColor: Colors.transparent,
                        indicatorColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Center(
                  child: CustomBtn(
                onTap: () {
                  context.goReplace(RouteName.login);
                  // Navigator.pushReplacementNamed(context, RouteName.login);
                },
                text: "Let’s Start",
                isLoading: false,
                isExpanded: true,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
