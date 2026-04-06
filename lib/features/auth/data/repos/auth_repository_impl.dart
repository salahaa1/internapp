import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasks_project/features/auth/data/dataresource/auth_remote_data_source.dart';
import 'package:tasks_project/features/auth/domin/repositries/authrepositry.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/error_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String mobileNo,
  }) async {
    try {
      final result = await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        mobileNo: mobileNo,
      );

      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorMapper.mapDioException(e));
    }
  }

  @override
  Future<Either<Failure, String>> verifyEmail({
    required String email,
    required String code,
  }) async {
    try {
      final result = await remoteDataSource.verifyEmail(
        email: email,
        code: code,
      );

      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorMapper.mapDioException(e));
    }
  }

  @override
  Future<Either<Failure, String>> resendVerification({
    required String email,
  }) async {
    try {
      final result = await remoteDataSource.resendVerification(email: email);

      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorMapper.mapDioException(e));
    }
  }

  @override
  Future<Either<Failure, String>> login({
    required String login,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        login: login,
        password: password,
      );

      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorMapper.mapDioException(e));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAccount({
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.deleteAccount(password: password);

      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorMapper.mapDioException(e));
    }
  }
}
