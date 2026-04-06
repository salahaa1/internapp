import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/features/tasks/domin/intities/task.dart';
import 'package:tasks_project/features/tasks/domin/usecase/get_tasks_usecase.dart';

import 'task_list_event.dart';
import 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final GetTasksUseCase getTasksUseCase;

  static const int _perPage = 10;

  TaskListBloc(this.getTasksUseCase) : super(TaskListLoading()) {
    on<FetchTasks>(_onFetchTasks);
    on<FetchNextPage>(_onFetchNextPage);
    on<RefreshTasks>(_onRefreshTasks);
    on<ToggleIncludeCompleted>(_onToggleIncludeCompleted);
    on<ChangeStatusFilter>(_onChangeStatusFilter);
  }

  List<Task> _applyStatusFilter(List<Task> tasks, int statusId) {
    if (statusId == 0) return tasks;
    return tasks.where((task) => task.statusId == statusId).toList();
  }

  Future<void> _onFetchTasks(
    FetchTasks event,
    Emitter<TaskListState> emit,
  ) async {
    emit(TaskListLoading());

    final result = await getTasksUseCase(
      page: 1,
      perPage: _perPage,
      includeCompleted: false,
    );

    result.fold((failure) => emit(TaskListError(failure.message)), (data) {
      emit(
        TaskListLoaded(
          tasks: _applyStatusFilter(data.tasks, 0),
          currentPage: data.meta.currentPage,
          lastPage: data.meta.lastPage,
          perPage: data.meta.perPage,
          total: data.meta.total,
          hasReachedMax: data.meta.currentPage >= data.meta.lastPage,
          includeCompleted: false,
          selectedStatusId: 0,
        ),
      );
    });
  }

  Future<void> _onFetchNextPage(
    FetchNextPage event,
    Emitter<TaskListState> emit,
  ) async {
    if (state is! TaskListLoaded) return;

    final currentState = state as TaskListLoaded;

    if (currentState.hasReachedMax || currentState.isLoadingMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;

    final result = await getTasksUseCase(
      page: nextPage,
      perPage: _perPage,
      includeCompleted: currentState.includeCompleted,
    );

    result.fold(
      (failure) {
        emit(currentState.copyWith(isLoadingMore: false));
      },
      (data) {
        final mergedTasks = [...currentState.tasks, ...data.tasks];
        final filteredTasks = _applyStatusFilter(
          mergedTasks,
          currentState.selectedStatusId,
        );

        emit(
          currentState.copyWith(
            tasks: filteredTasks,
            currentPage: data.meta.currentPage,
            lastPage: data.meta.lastPage,
            perPage: data.meta.perPage,
            total: data.meta.total,
            hasReachedMax: data.meta.currentPage >= data.meta.lastPage,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<void> _onRefreshTasks(
    RefreshTasks event,
    Emitter<TaskListState> emit,
  ) async {
    final includeCompleted = state is TaskListLoaded
        ? (state as TaskListLoaded).includeCompleted
        : false;
    final selectedStatusId = state is TaskListLoaded
        ? (state as TaskListLoaded).selectedStatusId
        : 0;

    emit(TaskListLoading());

    final result = await getTasksUseCase(
      page: 1,
      perPage: _perPage,
      includeCompleted: includeCompleted,
    );

    result.fold((failure) => emit(TaskListError(failure.message)), (data) {
      emit(
        TaskListLoaded(
          tasks: _applyStatusFilter(data.tasks, selectedStatusId),
          currentPage: data.meta.currentPage,
          lastPage: data.meta.lastPage,
          perPage: data.meta.perPage,
          total: data.meta.total,
          hasReachedMax: data.meta.currentPage >= data.meta.lastPage,
          includeCompleted: includeCompleted,
          selectedStatusId: selectedStatusId,
        ),
      );
    });
  }

  Future<void> _onToggleIncludeCompleted(
    ToggleIncludeCompleted event,
    Emitter<TaskListState> emit,
  ) async {
    final selectedStatusId = state is TaskListLoaded
        ? (state as TaskListLoaded).selectedStatusId
        : 0;

    emit(TaskListLoading());

    final result = await getTasksUseCase(
      page: 1,
      perPage: _perPage,
      includeCompleted: event.includeCompleted,
    );

    result.fold((failure) => emit(TaskListError(failure.message)), (data) {
      emit(
        TaskListLoaded(
          tasks: _applyStatusFilter(data.tasks, selectedStatusId),
          currentPage: data.meta.currentPage,
          lastPage: data.meta.lastPage,
          perPage: data.meta.perPage,
          total: data.meta.total,
          hasReachedMax: data.meta.currentPage >= data.meta.lastPage,
          includeCompleted: event.includeCompleted,
          selectedStatusId: selectedStatusId,
        ),
      );
    });
  }

  Future<void> _onChangeStatusFilter(
    ChangeStatusFilter event,
    Emitter<TaskListState> emit,
  ) async {
    if (state is! TaskListLoaded) return;

    final currentState = state as TaskListLoaded;

    emit(
      currentState.copyWith(
        tasks: _applyStatusFilter(currentState.tasks, event.statusId),
        selectedStatusId: event.statusId,
      ),
    );
  }
}
