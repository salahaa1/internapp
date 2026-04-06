abstract class TaskListEvent {}

class FetchTasks extends TaskListEvent {}

class FetchNextPage extends TaskListEvent {}

class RefreshTasks extends TaskListEvent {}

class ToggleIncludeCompleted extends TaskListEvent {
  final bool includeCompleted;

  ToggleIncludeCompleted(this.includeCompleted);
}

class ChangeStatusFilter extends TaskListEvent {
  final int statusId;

  ChangeStatusFilter(this.statusId);
}
