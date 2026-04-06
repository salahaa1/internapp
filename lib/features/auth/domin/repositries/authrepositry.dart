import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String mobileNo,
  });

  Future<Either<Failure, String>> verifyEmail({
    required String email,
    required String code,
  });

  Future<Either<Failure, String>> resendVerification({required String email});

  Future<Either<Failure, String>> login({
    required String login,
    required String password,
  });

  Future<Either<Failure, String>> deleteAccount({required String password});
}
