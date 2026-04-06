import 'package:dartz/dartz.dart';
import 'package:tasks_project/features/auth/domin/repositries/authrepositry.dart';
import '../../../../core/error/failures.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String mobileNo,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      mobileNo: mobileNo,
    );
  }
}
