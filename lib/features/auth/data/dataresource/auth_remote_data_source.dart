import 'package:dio/dio.dart';
import 'package:tasks_project/core/constant/apiconstant.dart';

abstract class AuthRemoteDataSource {
  Future<String> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String mobileNo,
  });

  Future<String> verifyEmail({required String email, required String code});

  Future<String> resendVerification({required String email});

  Future<String> login({required String login, required String password});

  Future<String> deleteAccount({required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<String> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String mobileNo,
  }) async {
    final response = await dio.post(
      ApiConstants.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'mobile_no': mobileNo,
      },
    );

    return response.data['message'];
  }

  @override
  Future<String> verifyEmail({
    required String email,
    required String code,
  }) async {
    final response = await dio.post(
      ApiConstants.verifyEmail,
      data: {'email': email, 'code': code},
    );

    return response.data['message'];
  }

  @override
  Future<String> resendVerification({required String email}) async {
    final response = await dio.post(
      ApiConstants.resendVerification,
      data: {'email': email},
    );

    return response.data['message'];
  }

  @override
  Future<String> login({
    required String login,
    required String password,
  }) async {
    final response = await dio.post(
      ApiConstants.login,
      data: {'login': login, 'password': password},
    );

    return response.data['data']['token'];
  }

  @override
  Future<String> deleteAccount({required String password}) async {
    final response = await dio.delete(
      ApiConstants.deleteAccount,
      data: {'password': password},
    );

    return response.data['message'];
  }
}
