import 'package:dartz/dartz.dart';
import 'package:tasks_project/features/tasks/domin/intities/paginated_tasks.dart';
import 'package:tasks_project/features/tasks/domin/repositries/tasks_repository.dart';
import '../../../../../core/error/failures.dart';

class GetTasksUseCase {
  final TasksRepository repository;

  GetTasksUseCase(this.repository);

  Future<Either<Failure, PaginatedTasks>> call({
    required int page,
    required int perPage,
    required bool includeCompleted,
  }) {
    return repository.getTasks(
      page: page,
      perPage: perPage,
      includeCompleted: includeCompleted,
    );
  }
}
