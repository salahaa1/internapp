import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/features/auth/domin/usecase/verify_email_usecase.dart';
import 'verify_email_event.dart';
import 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final VerifyEmailUseCase verifyEmailUseCase;

  VerifyEmailBloc(this.verifyEmailUseCase) : super(VerifyEmailInitial()) {
    on<VerifyEmailSubmitted>(_onVerifyEmailSubmitted);
  }

  Future<void> _onVerifyEmailSubmitted(
    VerifyEmailSubmitted event,
    Emitter<VerifyEmailState> emit,
  ) async {
    emit(VerifyEmailLoading());

    final result = await verifyEmailUseCase(
      email: event.email,
      code: event.code,
    );

    result.fold(
      (failure) {
        final message = failure.message.toLowerCase();

        if (message.contains('expired')) {
          emit(VerifyEmailExpiredCode(failure.message));
          return;
        }

        if (message.contains('invalid') ||
            message.contains('wrong') ||
            message.contains('incorrect')) {
          emit(VerifyEmailWrongCode(failure.message));
          return;
        }

        emit(VerifyEmailError(failure.message));
      },
      (message) {
        emit(VerifyEmailSuccess(message));
      },
    );
  }
}
