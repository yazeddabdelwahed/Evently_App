import 'package:evently_c16_online/core/provider/app_provider.dart';
import 'package:evently_c16_online/core/routes/route_gen.dart';
import 'package:evently_c16_online/core/servces/shared_servces.dart';
import 'package:evently_c16_online/core/theme/app_theme.dart';
import 'package:evently_c16_online/modules/splash/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:evently_c16_online/l10n/app_localizations.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Locale(provider.locale),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
       themeMode: provider.themeMode,
      onGenerateRoute: RouteGen.onGenerateRoute,
    );
  }
}

extension Localization on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this)!;
}

extension Navigators on BuildContext {
  void go(String routeName) {
    Navigator.pushNamed(this, routeName);
  } void goReplace(String routeName) {
    Navigator.pushReplacementNamed(this, routeName);
  }
}
