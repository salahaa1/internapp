import 'package:dartz/dartz.dart';
import 'package:tasks_project/features/auth/domin/repositries/authrepositry.dart';
import '../../../../core/error/failures.dart';

class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String email,
    required String code,
  }) {
    return repository.verifyEmail(email: email, code: code);
  }
}
