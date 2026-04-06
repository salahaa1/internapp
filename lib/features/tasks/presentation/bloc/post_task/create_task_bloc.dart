import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/features/tasks/domin/usecase/create_task_usecase.dart';

import 'create_task_event.dart';
import 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  final CreateTaskUseCase createTaskUseCase;

  CreateTaskBloc(this.createTaskUseCase) : super(CreateTaskInitial()) {
    on<CreateTaskSubmitted>(_onCreateTaskSubmitted);
  }

  Future<void> _onCreateTaskSubmitted(
    CreateTaskSubmitted event,
    Emitter<CreateTaskState> emit,
  ) async {
    emit(CreateTaskLoading());

    final result = await createTaskUseCase(params: event.params);

    result.fold(
      (failure) => emit(CreateTaskError(failure.message)),
      (_) => emit(CreateTaskSuccess()),
    );
  }
}
