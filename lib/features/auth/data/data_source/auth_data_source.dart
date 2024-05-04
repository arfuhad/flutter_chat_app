import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthDataSource(this._firebaseAuth);

  Future<Either<String, User>> signup(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      log("Auth Data Source: sign up: Error: $e");
      return left(e.message ?? 'Failed to Signup.');
    }
  }

  Future<Either<String, User?>> login(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(response.user);
    } on FirebaseAuthException catch (e) {
      log("Auth Data Source: login: Error: $e");
      return left(e.message ?? 'Failed to Login');
    }
  }

  Future<Either<String, bool>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return right(true);
    } on FirebaseAuthException catch (e) {
      log("Auth Data Source: sign out: Error: $e");
      return left(e.message ?? 'Failed to Login');
    }
  }
}

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSource(injector<FirebaseAuthService>().getAuth),
);
