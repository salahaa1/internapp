import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import 'package:tasks_project/features/auth/domin/repositries/authrepositry.dart';

class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<Either<Failure, String>> call({required String password}) {
    return repository.deleteAccount(password: password);
  }
}
