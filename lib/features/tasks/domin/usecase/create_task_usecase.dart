import 'package:dartz/dartz.dart';
import 'package:tasks_project/features/tasks/domin/intities/create_task_params.dart';
import 'package:tasks_project/features/tasks/domin/repositries/tasks_repository.dart';
import '../../../../core/error/failures.dart';

class CreateTaskUseCase {
  final TasksRepository repository;

  CreateTaskUseCase(this.repository);

  Future<Either<Failure, void>> call({required CreateTaskParams params}) {
    return repository.createTask(params: params);
  }
}
