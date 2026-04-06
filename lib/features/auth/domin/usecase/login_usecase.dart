import 'package:dartz/dartz.dart';
import 'package:tasks_project/features/auth/domin/repositries/authrepositry.dart';
import '../../../../core/error/failures.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String login,
    required String password,
  }) {
    return repository.login(login: login, password: password);
  }
}
