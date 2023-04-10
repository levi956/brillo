// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:brillo_assessment/core/connection/handler.dart';
import 'package:brillo_assessment/core/setups/run.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import '../models/auth_models.dart';

final authStateChanges = StreamProvider.autoDispose<AuthState>((ref) async* {
  yield* supabase!.auth.onAuthStateChange;
});

final userProvider = StateProvider<User?>((ref) {
  User? _user;
  return _user;
});

class AuthServices {
  final ProviderRef? ref;

  AuthServices({this.ref});

  static User? _user;

  static User get currentUser => _user!;

  FutureHandler<String> logout() {
    return serveFuture<String>(
      function: (fail) async {
        await supabase!.auth.signOut();

        return 'Signed out';
      },
    );
  }

  FutureHandler<String> login(LoginModel model) {
    return serveFuture<String>(
      function: (fail) async {
        final _x = await supabase!.auth.signInWithPassword(
          password: model.password,
          email: model.email,
        );

        _user = _x.user;
        ref!.read(userProvider.notifier).state = _user;
        return 'User Logged!';
      },
    );
  }

  FutureHandler<String> signUp(RegisterModel model) async {
    return serveFuture<String>(
      function: (fail) async {
        final user = await supabase!.auth.signUp(
          password: model.password,
          email: model.email,
          data: {
            'username': model.username,
            'name': model.name,
          },
        );
        _user = user.user;
        ref!.read(userProvider.notifier).state = _user;
        return 'Signed up successfully';
      },
    );
  }

  FutureHandler<String> forgotPassword(String email) async {
    return serveFuture<String>(
      function: (fail) async {
        await supabase!.auth.resetPasswordForEmail(email);
        return 'A reset link has been sent to your email';
      },
    );
  }

  FutureHandler<String> updateEmail(String email) async {
    return serveFuture<String>(
      function: (fail) async {
        final r = await supabase!.auth.updateUser(
          UserAttributes(email: email),
        );
        _user = r.user;
        ref!.read(userProvider.notifier).state = _user;
        return 'Email Updated';
      },
    );
  }

  FutureHandler<String> updatePassword(String password) async {
    return serveFuture<String>(
      function: (fail) async {
        final r = await supabase!.auth.updateUser(
          UserAttributes(password: password),
        );
        _user = r.user;
        return 'Password Updated';
      },
    );
  }

  FutureHandler<String> updateUsername(String username) async {
    return serveFuture<String>(
      function: (fail) async {
        final r = await supabase!.auth.updateUser(
          UserAttributes(
            data: {'username': username},
          ),
        );
        _user = r.user;
        ref!.read(userProvider.notifier).state = _user;
        return 'Username Updated!';
      },
    );
  }

  FutureHandler<String> insertUser(RegisterModel model) async {
    return serveFuture<String>(
      function: (fail) async {
        final currentUser = ref!.read(userProvider.notifier).state;
        await supabase!.from('users').insert(
          {
            'id': currentUser!.id,
            'name': currentUser.userMetadata!['name'],
            'email': currentUser.email,
            'phone': currentUser.phone,
            'username': currentUser.userMetadata!['username'],
          },
        );
        return 'Success';
      },
    );
  }
}
