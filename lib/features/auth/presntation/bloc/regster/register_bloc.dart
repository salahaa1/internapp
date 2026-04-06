import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/features/auth/domin/usecase/registerusecas.dart';
import 'package:tasks_project/features/auth/presntation/bloc/regster/regster_event.dart'
    show RegisterEvent, RegisterSubmitted;

import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    final result = await registerUseCase(
      name: event.name,
      email: event.email,
      password: event.password,
      passwordConfirmation: event.passwordConfirmation,
      mobileNo: event.mobileNo,
    );

    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (message) => emit(RegisterSuccess(message)),
    );
  }
}
