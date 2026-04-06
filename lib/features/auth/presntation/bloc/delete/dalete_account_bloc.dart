import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/features/auth/domin/usecase/deleteusecase.dart';
import 'delete_account_event.dart';
import 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final DeleteAccountUseCase deleteAccountUseCase;

  DeleteAccountBloc(this.deleteAccountUseCase) : super(DeleteAccountInitial()) {
    on<DeleteAccountSubmitted>(_onDeleteAccountSubmitted);
  }

  Future<void> _onDeleteAccountSubmitted(
    DeleteAccountSubmitted event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(DeleteAccountLoading());

    final result = await deleteAccountUseCase(password: event.password);

    result.fold(
      (failure) => emit(DeleteAccountError(failure.message)),
      (message) => emit(DeleteAccountSuccess(message)),
    );
  }
}
