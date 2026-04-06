import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tasks_project/core/constant/apiconstant.dart';
import 'auth_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient({required FlutterSecureStorage secureStorage})
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      ) {
    dio.interceptors.add(AuthInterceptor(secureStorage));
  }
}
