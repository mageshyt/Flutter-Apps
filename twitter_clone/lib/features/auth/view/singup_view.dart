import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';
import 'package:twitter_clone/theme/pallet.dart';

class SingUpView extends ConsumerStatefulWidget {
  const SingUpView({Key? key}) : super(key: key);
  static route() => MaterialPageRoute(builder: (context) => const SingUpView());
  @override
  ConsumerState<SingUpView> createState() => _SingUpViewState();
}

class _SingUpViewState extends ConsumerState<SingUpView> {
  final appbar = UIConstants.appBar();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSinUp() {
    ref.read(AuthControllerProvider.notifier).SignUp(
        email: emailController.text,
        password: passwordController.text,
        context: context);
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
              // Name
              AuthField(controller: emailController, hint_text: "Name"),
              const SizedBox(height: 20),
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
                  onTap: onSinUp,
                  size: "sm",
                  label: "Sign up",
                  bgColor: Pallete.whiteColor,
                  textColor: Pallete.backgroundColor,
                ),
              ),
              const SizedBox(height: 30),

              // Rich Text

              RichText(
                text: TextSpan(
                  text: "Already have an account ? ",
                  style: const TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: " Login",
                      style: const TextStyle(
                          color: Pallete.blueColor,
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(context, LoginView.route());
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
