import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_c16_online/core/provider/app_provider.dart';
import 'package:evently_c16_online/core/routes/app_route_name.dart';
import 'package:evently_c16_online/core/widgets/custom_btn.dart';
import 'package:evently_c16_online/modules/auth/manager/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import 'package:evently_c16_online/l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context)!;
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AuthProvider>(builder: (context, provider, child) {
            return Form(
              key: provider.formKey,
                child: Column(
              children: [
                const Spacer(),
                Center(
                    child: Hero(
                        tag: "logo",
                        child: Image.asset("assets/logo/app_logo.png"))),
                Hero(
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
                Spacer(),
                TextFormField(
                  controller: provider.emailController,
                  validator: (value) {
                    bool isEmail = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value == null || value.isEmpty) {
                      return "Please enter Email";
                    } else if (!isEmail) {
                      return "Please enter valid Email";
                    } else {
                      return null;
                    }
                  },
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail), hintText: locale.email),
                ),
                const SizedBox(
                  height: 12,
                ),
                StatefulBuilder(
                  builder: (context, setState) {
                    return TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter password";
                        } else if (value.length < 6) {
                          return "must be length more 6 number";
                        } else {
                          return null;
                        }
                      },
                      controller: provider.passwordController,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      obscureText: isShowPassword,
                      // obscuringCharacter: "\$",
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: locale.password,
                          suffixIcon: InkWell(
                            onTap: () {
                              isShowPassword = !isShowPassword;
                              setState(() {});
                            },
                            child: Icon(isShowPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          )),
                    );
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.forgetPassword);
                      },
                      child: Text(
                        locale.forgetPassword,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                CustomBtn(
                    isLoading: provider.isLoading,
                    isExpanded: true, onTap: () {
                      provider.login(context);
                }, text: locale.login),
                Spacer(),
                Text.rich(TextSpan(text: locale.notHaveAccount, children: [
                  TextSpan(
                      text: locale.createAccount,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(
                              context, RouteName.register);
                        }),
                ])),
                Spacer(),
                AnimatedToggleSwitch<String>.rolling(
                  indicatorIconScale: 1.2,
                  current: appProvider.locale,
                  values: const ["en", "ar"],
                  iconList: [
                    Image.asset("assets/icons/en.png"),
                    Image.asset("assets/icons/ar.png"),
                  ],
                  onChanged: (value) {
                    appProvider.changeLanguage(value);
                  },
                  style: ToggleStyle(
                    backgroundColor: Colors.transparent,
                    indicatorColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                  ),
                  textDirection: TextDirection.ltr,
                ),
                Spacer(),
              ],
            ));
          },),
        ),
      ),
    );
  }
}
