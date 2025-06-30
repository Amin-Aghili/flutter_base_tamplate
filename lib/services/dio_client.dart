import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

typedef RefreshTokenCallback = Future<bool> Function();

class DioClient {
  final Dio _dio;
  static String? _token;
  static RefreshTokenCallback? refreshTokenCallback;
  int _refreshAttempts = 0;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.example.com', // paste your API base URL here
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null && _token!.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 && _refreshAttempts < 3) {
            _refreshAttempts++;
            debugPrint('⚠️ Token expired, attempting to refresh...');

            if (refreshTokenCallback != null) {
              bool refreshed = await refreshTokenCallback!();
              if (refreshed) {
                debugPrint('✅ Token refreshed. Retrying request...');
                final RequestOptions requestOptions = error.requestOptions;
                requestOptions.headers['Authorization'] = 'Bearer $_token';

                try {
                  final Response response = await _dio.fetch(requestOptions);
                  return handler.resolve(response);
                } catch (e) {
                  debugPrint('❌ Retried request failed: $e');
                }
              }
            }

            debugPrint('❌ Token refresh failed. Redirecting to login...');
            return handler.reject(error);
          }

          return handler.next(error);
        },
      ),
    );
  }

  void setToken(String token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
  }

  Dio get client => _dio;
}
