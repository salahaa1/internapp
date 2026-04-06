import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasks_project/core/error/error_mapper.dart';
import 'package:tasks_project/core/error/failures.dart';
import 'package:tasks_project/features/tasks/data/datasource/task_remot_datasource.dart';
import 'package:tasks_project/features/tasks/domin/intities/create_task_params.dart';
import 'package:tasks_project/features/tasks/domin/intities/paginated_tasks.dart';
import 'package:tasks_project/features/tasks/domin/repositries/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDataSource remoteDataSource;

  TasksRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedTasks>> getTasks({
    required int page,
    required int perPage,
    required bool includeCompleted,
  }) async {
    try {
      final result = await remoteDataSource.getTasks(
        page: page,
        perPage: perPage,
        includeCompleted: includeCompleted,
      );

      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorMapper.mapDioException(e));
    }
  }

  @override
  Future<Either<Failure, void>> createTask({
    required CreateTaskParams params,
  }) async {
    try {
      await remoteDataSource.createTask(params: params);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ErrorMapper.mapDioException(e));
    }
  }
}
