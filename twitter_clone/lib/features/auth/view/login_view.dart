// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:twitter_clone/common/rounded_button.dart';

import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';
import 'package:twitter_clone/theme/pallet.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appbar = UIConstants.appBar();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              // Email
              AuthField(controller: emailController, hint_text: "Email"),
              const SizedBox(height: 20),
              // password
              AuthField(
                controller: passwordController,
                hint_text: "password",
              ),
              const SizedBox(height: 30),
              // button

              Align(
                alignment: Alignment.topRight,
                child: RoundedButton(
                  onTap: () {},
                  size: "sm",
                  label: "Submit",
                  bgColor: Pallete.whiteColor,
                  textColor: Pallete.backgroundColor,
                ),
              ),
              const SizedBox(height: 30),

              // Rich Text

              RichText(
                text: const TextSpan(
                  text: "Don't have an accouht ? ",
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                        text: " Sing Up",
                        style: TextStyle(
                            color: Pallete.blueColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
