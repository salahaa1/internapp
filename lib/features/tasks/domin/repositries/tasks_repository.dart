import 'package:dartz/dartz.dart';
import 'package:tasks_project/features/tasks/domin/intities/create_task_params.dart';
import 'package:tasks_project/features/tasks/domin/intities/paginated_tasks.dart';
import '../../../../../core/error/failures.dart';

abstract class TasksRepository {
  Future<Either<Failure, PaginatedTasks>> getTasks({
    required int page,
    required int perPage,
    required bool includeCompleted,
  });
  Future<Either<Failure, void>> createTask({required CreateTaskParams params});
}
