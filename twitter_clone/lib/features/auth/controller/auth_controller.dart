// ignore_for_file: non_constant_identifier_names
import 'package:appwrite/models.dart' as model;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/models/user_model.dart';

final AuthControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authAPIProvider), userAPI: ref.watch(userAPIProvider));
});

final CurrentUserProvider = FutureProvider((ref) {
  final authController = ref.watch(AuthControllerProvider.notifier);
  return authController.currentUser();
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(CurrentUserProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));

  return userDetails.value;
});

// to get user details from uid
final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(AuthControllerProvider.notifier);
  return authController.getUserData(uid);
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
      (l) => showSnackBar(
          context, l.message, "Sign up error", ContentType.failure),
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

        final res2 = await _userAPI.saveUserData(user);
        res2.fold(
          (l) => showSnackBar(
              context, l.message, "Sign up error", ContentType.failure),
          (r) => {
            showSnackBar(context, "Account created successfully ", "Success",
                ContentType.success),
            Navigator.pop(context),
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
        (l) => showSnackBar(
            context, l.message, "Login error", ContentType.failure),
        (r) => {
              showSnackBar(context, "Logined successfully ", "Success",
                  ContentType.success),
              Navigator.pop(context),
              Navigator.push(context, HomeView.route())
            });
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserDetails(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }
}
