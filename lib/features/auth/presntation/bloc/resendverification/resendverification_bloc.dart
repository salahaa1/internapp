import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/features/auth/domin/usecase/resendverifycation_usecase.dart';
import 'package:tasks_project/features/auth/presntation/bloc/resendverification/resendverificarion_event.dart';
import 'package:tasks_project/features/auth/presntation/bloc/resendverification/resendverification_state.dart';

class ResendVerificationBloc
    extends Bloc<ResendVerificationEvent, ResendVerificationState> {
  final ResendVerificationUseCase resendVerificationUseCase;

  ResendVerificationBloc(this.resendVerificationUseCase)
    : super(ResendVerificationInitial()) {
    on<ResendVerificationSubmitted>(_onResendVerificationSubmitted);
  }

  Future<void> _onResendVerificationSubmitted(
    ResendVerificationSubmitted event,
    Emitter<ResendVerificationState> emit,
  ) async {
    emit(ResendVerificationLoading());

    final result = await resendVerificationUseCase(email: event.email);

    result.fold(
      (failure) => emit(ResendVerificationError(failure.message)),
      (message) => emit(ResendVerificationSuccess(message)),
    );
  }
}
