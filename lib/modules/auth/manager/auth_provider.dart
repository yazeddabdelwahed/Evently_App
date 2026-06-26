import 'package:evently_c16_online/core/dialogs/app_dialogs.dart';
import 'package:evently_c16_online/core/routes/app_route_name.dart';
import 'package:evently_c16_online/modules/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Future<void> createAccount(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      try {
        var data = await AuthServices.createAccount(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text);
        if (data != null) {
          AppDialogs.showMessage(context, "Check Your email",
              type: DialogType.success);
        }
      } catch (e) {
        AppDialogs.showMessage(context, e.toString(), type: DialogType.error);
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      try {
        var user = await AuthServices.login(
            email: emailController.text, password: passwordController.text);
        if (true) {
          AppDialogs.showMessage(context, "Welcome  ${user!.user!.displayName}");
          Navigator.pushReplacementNamed(context, RouteName.layout);
        } else {
          AppDialogs.showMessage(
              context, "Email not Verified , check Your email",
              type: DialogType.error);
        }
      } catch (e) {
        AppDialogs.showMessage(context, "Invalid Email Or Password",
            type: DialogType.error);
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
