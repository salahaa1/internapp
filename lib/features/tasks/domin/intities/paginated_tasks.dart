import 'task.dart';
import 'pagination_meta.dart';

class PaginatedTasks {
  final List<Task> tasks;
  final PaginationMeta meta;

  const PaginatedTasks({required this.tasks, required this.meta});
}
