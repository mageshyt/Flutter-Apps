// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/singup_view.dart';

import 'package:twitter_clone/features/auth/widgets/auth_field.dart';
import 'package:twitter_clone/theme/pallet.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static route() => MaterialPageRoute(builder: (context) => const LoginView());
  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    ref.read(AuthControllerProvider.notifier).Login(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(AuthControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const LoadingPage()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    SvgPicture.asset(
                      AssetsConstants.loginPageImage,
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(height: 40),
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
                        onTap: login,
                        size: "sm",
                        label: "Submit",
                        bgColor: Pallete.whiteColor,
                        textColor: Pallete.backgroundColor,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Rich Text

                    RichText(
                      text: TextSpan(
                        text: "Don't have an account ? ",
                        style: const TextStyle(fontSize: 16),
                        children: [
                          TextSpan(
                            text: " Sing Up",
                            style: const TextStyle(
                                color: Pallete.blueColor,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, SingUpView.route());
                              },
                          ),
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
