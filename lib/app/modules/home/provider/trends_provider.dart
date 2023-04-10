import 'package:brillo_assessment/app/modules/home/services/sport_trend_services.dart';
import 'package:brillo_assessment/core/connection/handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/news_model.dart';

final latestTrendsProvider =
    FutureProvider.autoDispose<ServiceResponse<List<NewsModel>>>((ref) async {
  return SportTrendServices.getLatestTrends();
});
