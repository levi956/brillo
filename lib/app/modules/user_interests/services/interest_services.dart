import 'package:brillo_assessment/app/modules/authentication/service/authentication_service.dart';
import 'package:brillo_assessment/core/connection/handler.dart';
import 'package:brillo_assessment/core/setups/run.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sport_model.dart';

final userInterestService = Provider<UserInterstService>((ref) {
  return UserInterstService(ref: ref);
});

class UserInterstService {
  ProviderRef? ref;

  UserInterstService({this.ref});

  static FutureHandler<List<SportInterest>> getUserInterest() {
    return serveFuture<List<SportInterest>>(
      function: (fail) async {
        final user = AuthServices.currentUser;
        List<dynamic> query = await supabase!
            .from('user_interest')
            .select('sport_interest')
            .eq('user_id', user.id);
        List<SportInterest> interest =
            query.map((e) => SportInterest.fromJson(e)).toList();
        return interest;
      },
    );
  }

  FutureHandler<String> addInterest(List<String> interests) {
    return serveFuture(
      function: (fail) async {
        for (String item in interests) {
          await supabase!.from('user_interest').insert(
            {'user_id': AuthServices.currentUser.id, 'sport_interest': item},
          );
        }
        return 'Interest recorded';
      },
    );
  }
}
