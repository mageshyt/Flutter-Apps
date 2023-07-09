// ignore_for_file: non_constant_identifier_names
import 'package:appwrite/models.dart' as model;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/models/user_mode.dart';

final AuthControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authAPIProvider), userAPI: ref.watch(userAPIProvider));
});

final CurrentUserProvider = FutureProvider((ref) {
  final authController = ref.watch(AuthControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _account;
  final UserAPI _userAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _account = authAPI,
        _userAPI = userAPI,
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
      (r) async {
        // save user data
        UserModel user = UserModel(
          uid: r.$id,
          name: r.name,
          email: r.email,
          avatar: '',
          bannerPic: '',
          bio: '',
          followers: const [],
          following: const [],
          isVerified: false,
        );
        print(user.toMap());

        final res2 = await _userAPI.saveUserData(user);
        res2.fold(
          (l) => showSnackBar(context, l.message),
          (r) => {
            showSnackBar(context, "Account created successfully "),
            Navigator.push(context, LoginView.route())
          },
        );
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
