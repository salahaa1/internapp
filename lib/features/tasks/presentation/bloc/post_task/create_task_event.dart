import 'package:tasks_project/features/tasks/domin/intities/create_task_params.dart';

abstract class CreateTaskEvent {}

class CreateTaskSubmitted extends CreateTaskEvent {
  final CreateTaskParams params;

  CreateTaskSubmitted(this.params);
}
