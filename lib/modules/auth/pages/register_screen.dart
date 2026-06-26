import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_c16_online/core/provider/app_provider.dart';
import 'package:evently_c16_online/core/widgets/custom_btn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/app_route_name.dart';
import '../../../core/theme/app_colors.dart';
import 'package:evently_c16_online/l10n/app_localizations.dart';
import '../manager/auth_provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

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
          child: Consumer<AuthProvider>(
            builder: (context, provider, child) {
              return Form(
                  key: provider.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 24,),
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
                        SizedBox(height: 24,),

                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter name";
                            } else {
                              return null;
                            }
                          },
                          controller: provider.nameController,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              hintText: locale.name),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
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
                          controller: provider.emailController,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.mail),
                              hintText: locale.email),
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
                                  prefixIcon: const Icon(Icons.lock),
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
                        const SizedBox(
                          height: 12,
                        ),
                        StatefulBuilder(
                          builder: (context, setState) {
                            return TextFormField(
                              validator: (value) {
                                if (value != provider.passwordController.text) {
                                  return "Password not Matched";
                                } else {
                                  return null;
                                }
                              },
                              controller: provider.rePasswordController,
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              obscureText: isShowPassword,
                              // obscuringCharacter: "\$",
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  hintText: locale.rePassword,
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
                        SizedBox(height: 24,),

                        CustomBtn(
                            isExpanded: true,
                            isLoading: provider.isLoading,
                            onTap: () {
                              provider.createAccount(context);
                            },
                            text: locale.createAccount),
                        SizedBox(height: 24,),

                        Text.rich(TextSpan(text: locale.haveAccount, children: [
                          TextSpan(
                              text: locale.login,
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, RouteName.login);
                                })
                        ])),
                        SizedBox(height: 24,),

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
                      ],
                    ),
                  )
              );
            },
          ),
        ),
      ),
    );
  }
}
