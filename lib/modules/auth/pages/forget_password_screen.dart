import 'package:evently_c16_online/core/widgets/custom_btn.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image.asset("assets/images/reset_password.png"),
            ),
            CustomBtn(isExpanded: true, onTap: () {}, text: "Reset Password")
          ],
        ),
      ),
    );
  }
}
