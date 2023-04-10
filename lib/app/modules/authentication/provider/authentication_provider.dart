import 'package:brillo_assessment/app/modules/authentication/models/auth_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/connection/handler.dart';
import '../service/authentication_service.dart';

final authServices = Provider<AuthServices>((ref) {
  return AuthServices(ref: ref);
});

final authRepo = Provider<AuthRepo>((ref) {
  final p = ref.read(authServices);
  return AuthRepo(p);
});

class AuthRepo {
  final AuthServices _auth;

  AuthRepo(this._auth);

  Future<void> login(
    LoginModel model, {
    required ValueChanged<ServiceResponse<String>> onDone,
  }) async {
    final x = await _auth.login(model);
    onDone(x);
  }

  Future<void> signUp(
    RegisterModel model, {
    required ValueChanged<ServiceResponse<String>> onDone,
  }) async {
    final x = await _auth.signUp(model);
    onDone(x);
  }

  Future<void> logout({
    required ValueChanged<ServiceResponse<String>> onDone,
  }) async {
    final x = await _auth.logout();
    onDone(x);
  }

  Future<void> forgotPassword(
    String email, {
    required ValueChanged<ServiceResponse<String>> onDone,
  }) async {
    final x = await _auth.forgotPassword(email);
    onDone(x);
  }

  Future<void> updateEmail(
    String email, {
    required ValueChanged<ServiceResponse<String>> onDone,
  }) async {
    final x = await _auth.updateEmail(email);
    onDone(x);
  }

  Future<void> updatePassword(
    String password, {
    required ValueChanged<ServiceResponse<String>> onDone,
  }) async {
    final x = await _auth.updatePassword(password);
    onDone(x);
  }

  Future<void> updateUsername(
    String username, {
    required ValueChanged<ServiceResponse<String>> onDone,
  }) async {
    final x = await _auth.updateUsername(username);
    onDone(x);
  }

  Future<void> insertUser(
    RegisterModel model, {
    required ValueChanged<ServiceResponse<String>> onDone,
  }) async {
    final x = await _auth.insertUser(model);
    onDone(x);
  }
}
