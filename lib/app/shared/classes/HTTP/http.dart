// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, constant_identifier_names

import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';

const _60seconds = Duration(seconds: 60);

final _customIntercepor = AwesomeDioInterceptor(
    logRequestTimeout: false,
    logRequestHeaders: false,
    logResponseHeaders: false);

const _rType = ResponseType.json;

class HTTP {
  static String get baseUrl => 'https://newsapi.org/v2/top-headlines?';

  static final Map<String, String> _headers = Map<String, String>.from(
    {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
  );

  static Map<String, String> get _getHeaders =>
      Map<String, String>.from(_headers);

  static List<String> headerLog = [];

  static addHeader({
    required String key,
    required String value,
  }) {
    _headers[key] = value;
    headerLog.add("$key: $value");
  }

  static Future<Response> get(String endpoint) async {
    final _dio = Dio(
      BaseOptions(
        responseType: _rType,
        headers: _getHeaders,
        connectTimeout: _60seconds,
        receiveTimeout: _60seconds,
      ),
    )..interceptors.add(_customIntercepor);
    String url = "$baseUrl$endpoint";
    final response = await _dio.get(url);
    return response;
  }
}

extension Extras on Response {
  bool get is200 => statusCode == 200;
  bool get is201 => statusCode == 201;
  bool get is202 => statusCode == 202;
  bool get is400 => statusCode == 400;
  bool get is409 => statusCode == 409;
  bool get is500 => statusCode == 500;
  bool get is401 => statusCode == 401;
  bool get is404 => statusCode == 404;
  bool get is502 => statusCode == 502;
}
