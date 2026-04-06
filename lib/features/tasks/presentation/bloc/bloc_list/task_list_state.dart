import 'package:tasks_project/features/tasks/domin/intities/task.dart';

abstract class TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListLoaded extends TaskListState {
  final List<Task> tasks;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final bool hasReachedMax;
  final bool includeCompleted;
  final bool isLoadingMore;
  final int selectedStatusId;

  TaskListLoaded({
    required this.tasks,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.hasReachedMax,
    required this.includeCompleted,
    required this.selectedStatusId,
    this.isLoadingMore = false,
  });

  TaskListLoaded copyWith({
    List<Task>? tasks,
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
    bool? hasReachedMax,
    bool? includeCompleted,
    bool? isLoadingMore,
    int? selectedStatusId,
  }) {
    return TaskListLoaded(
      tasks: tasks ?? this.tasks,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      includeCompleted: includeCompleted ?? this.includeCompleted,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedStatusId: selectedStatusId ?? this.selectedStatusId,
    );
  }
}

class TaskListError extends TaskListState {
  final String message;

  TaskListError(this.message);
}
