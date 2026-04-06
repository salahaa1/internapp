import 'package:tasks_project/features/tasks/domin/intities/paginated_tasks.dart';

import 'task_model.dart';
import 'pagination_meta_model.dart';

class PaginatedTasksModel extends PaginatedTasks {
  const PaginatedTasksModel({required super.tasks, required super.meta});

  factory PaginatedTasksModel.fromJson(Map<String, dynamic> json) {
    return PaginatedTasksModel(
      tasks: (json['data'] as List).map((e) => TaskModel.fromJson(e)).toList(),
      meta: PaginationMetaModel.fromJson(json['meta']),
    );
  }
}
