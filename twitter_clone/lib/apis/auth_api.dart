import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/provider.dart';

// want to sign up , want to get user account -> Account
// want to access user related data -> model.account

final authAPIProvider =
    Provider((ref) => AuthAPI(account: ref.watch(appwriteAccountProvider)));

abstract class IAuthAPI {
  FutureEither<model.User> signUp(
      {required String email, required String password});
}

class AuthAPI implements IAuthAPI {
  final Account _account;

  AuthAPI({required Account account}) : _account = account;
  @override
  FutureEither<model.User> signUp(
      {required String email, required String password}) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: password);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
          message: e.message ?? 'something went wrong',
          stackTrace: stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  // login user

  FutureEither<String> login(
      {required String email, required String password}) async {
    try {
      final res =
          await _account.createEmailSession(email: email, password: password);

      print(res);
      return right(res.userId);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
          message: e.message ?? 'something went wrong',
          stackTrace: stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }
}
