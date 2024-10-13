import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_shop/models/register_model.dart';

class AuthRepository {
  static final AuthRepository _authRepository = AuthRepository._internal();

  factory AuthRepository() {
    return _authRepository;
  }

  AuthRepository._internal();

  Future<RegisterModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("users/${credential.user?.uid}");
      final result = await ref.once();
      final registerModel =
          RegisterModel.fromJson(result.snapshot.value as Map);
      return registerModel;
    } on FirebaseAuthException catch (_) {
    } catch (_) {}
    return null;
  }

  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    bool success = false;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final registerModel = RegisterModel(
        fullName: fullName,
        email: email,
        uuid: credential.user?.uid ?? '',
        isAdmin: false,
      );

      DatabaseReference ref =
          FirebaseDatabase.instance.ref("users/${credential.user?.uid}");
      await ref.set(registerModel.toJson());
      success = true;
    } on FirebaseAuthException catch (_) {
      log('error');
    } catch (_) {
      log('error');
    }
    return success;
  }
}
