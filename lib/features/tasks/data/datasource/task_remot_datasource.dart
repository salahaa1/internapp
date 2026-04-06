import 'package:dio/dio.dart';
import 'package:tasks_project/core/constant/apiconstant.dart';
import 'package:tasks_project/features/tasks/domin/intities/create_task_params.dart';

import '../models/paginated_tasks_model.dart';

abstract class TasksRemoteDataSource {
  Future<PaginatedTasksModel> getTasks({
    required int page,
    required int perPage,
    required bool includeCompleted,
  });

  Future<void> createTask({required CreateTaskParams params});
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final Dio dio;

  TasksRemoteDataSourceImpl({required this.dio});

  @override
  Future<PaginatedTasksModel> getTasks({
    required int page,
    required int perPage,
    required bool includeCompleted,
  }) async {
    final response = await dio.get(
      ApiConstants.task,
      queryParameters: {
        'page': page,
        'per_page': perPage,
        'include_completed': includeCompleted ? 1 : 0,
      },
    );
    print('🔥 GET TASKS RESPONSE: ${response.data}');

    return PaginatedTasksModel.fromJson(response.data);
  }

  @override
  Future<void> createTask({required CreateTaskParams params}) async {
    final response = await dio.post(
      ApiConstants.task,
      data: {
        'task_name': params.taskName,
        'description': params.description,
        'priority': params.priority,
        'start_date': params.startDate,
        'due_date': params.dueDate,
        'status_id': params.statusId,
        'assigned_user_ids': params.assignedUserIds,
        'owner_id': params.ownerId,
        'assignment_type': params.assignmentType,
        'execute_task_individually': params.executeTaskIndividually,
        'recurrence_type': params.recurrenceType,
      },
    );
    print('🔥 CREATE TASK RESPONSE: ${response.data}');
  }
}
