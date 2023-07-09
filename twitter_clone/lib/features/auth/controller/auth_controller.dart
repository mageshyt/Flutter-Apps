// ignore_for_file: non_constant_identifier_names
import 'package:appwrite/models.dart' as model;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';

final AuthControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authAPI: ref.watch(authAPIProvider));
});

final CurrentUserProvider = FutureProvider((ref) {
  final authController = ref.watch(AuthControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _account;
  AuthController({required AuthAPI authAPI})
      : _account = authAPI,
        super(false);

  // state = isLoading

  // _account.get() -> session of user

  Future<model.User?> currentUser() => _account.getAccount();

  void SignUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res =
        await _account.signUp(name: name, email: email, password: password);
    state = false;
    return res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => {
        showSnackBar(context, "Account Created ! please Login "),
        Navigator.push(context, LoginView.route())
      },
    );
  }

  void Login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _account.login(email: email, password: password);
    state = false;
    return res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => {
              showSnackBar(context, "Logined successfully "),
              Navigator.push(context, HomeView.route())
            });
  }
}
