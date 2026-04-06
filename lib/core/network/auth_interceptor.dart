import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;

  AuthInterceptor(this.secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final url = options.uri.toString();

    final isAuthRequest =
        url.contains('/auth/login') ||
        url.contains('/auth/register') ||
        url.contains('/auth/verify-email') ||
        url.contains('/auth/resend-verification');

    final token = await secureStorage.read(key: 'token');

    print('URL: $url');
    print('🔥 TOKEN FROM STORAGE: $token');

    if (!isAuthRequest && token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    handler.next(options);
  }
}
