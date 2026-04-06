import 'package:tasks_project/features/tasks/domin/intities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.taskName,
    required super.description,
    required super.priority,
    required super.startDate,
    required super.dueDate,
    required super.statusId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? 0,
      taskName: json['name'] ?? '',
      description: json['description'] ?? '',
      priority: json['priority'] ?? '',
      startDate: json['dates']?['start'] ?? '',
      dueDate: json['dates']?['due'] ?? '',
      statusId: json['status']?['id'] ?? 0,
    );
  }
}
