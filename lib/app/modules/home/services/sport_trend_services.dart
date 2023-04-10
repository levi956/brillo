import 'package:brillo_assessment/app/shared/classes/HTTP/http.dart';
import 'package:brillo_assessment/core/connection/handler.dart';

import '../models/news_model.dart';

class SportTrendServices {
  static FutureHandler<List<NewsModel>> getLatestTrends() async {
    return serveFuture<List<NewsModel>>(
      function: (fail) async {
        HTTP.addHeader(
          key: 'Authorization',
          value: 'fae23e0131604ca99bd4b7c2fa7915c9',
        );
        final r = await HTTP.get('country=ng&category=sport');
        if (r.is200 || r.is201) {
          List<dynamic> body = r.data['articles'];
          final news = body.map((e) => NewsModel.fromJson(e)).toList();
          return news;
        }
        return fail(r.data['message'] ?? 'SSomething went wrong');
      },
    );
  }
}
