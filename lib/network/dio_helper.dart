import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? _dio;
  static init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://www.boredapi.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    required dynamic query,
  }) async {
    return await _dio?.get(
      url,
      queryParameters: query,
    );
  }
}
