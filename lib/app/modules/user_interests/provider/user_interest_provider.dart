import 'package:brillo_assessment/app/modules/user_interests/services/interest_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/connection/handler.dart';
import '../models/sport_model.dart';

final userInterestRepo = Provider<UserInterestRepo>((ref) {
  final p = ref.read(userInterestService);
  return UserInterestRepo(p);
});

final userInterestProvider =
    FutureProvider.autoDispose<ServiceResponse<List<SportInterest>>>(
        (ref) async {
  return UserInterstService.getUserInterest();
});

class UserInterestRepo {
  final UserInterstService _client;

  UserInterestRepo(this._client);

  Future<void> insertInterest(
    List<String> interest, {
    required ValueChanged<ServiceResponse<String>> onDone,
  }) async {
    final p = await _client.addInterest(interest);
    onDone(p);
  }
}
