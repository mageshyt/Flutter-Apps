// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/core.dart';

final AuthControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authAPI: ref.watch(authAPIProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authApi;
  AuthController({required AuthAPI authAPI})
      : _authApi = authAPI,
        super(false);

  void SignUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authApi.signUp(email: email, password: password);
    state = false;
    return res.fold(
        (l) => showSnackBar(context, l.message), (r) => print(r.email));
  }

  void Login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authApi.login(email: email, password: password);
    state = false;
    return res.fold((l) => showSnackBar(context, l.message), (r) => print(r));
  }
}
