import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tasks_project/features/auth/domin/usecase/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final FlutterSecureStorage secureStorage;

  LoginBloc(this.loginUseCase, this.secureStorage) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    final result = await loginUseCase(
      login: event.login,
      password: event.password,
    );

    await result.fold(
      (failure) async {
        final message = failure.message.toLowerCase();

        if (message.contains('verify') ||
            message.contains('unverified') ||
            message.contains('not verified')) {
          emit(LoginUnverified(failure.message));
        } else {
          emit(LoginError(failure.message));
        }
      },
      (token) async {
        await secureStorage.write(key: 'token', value: token);

        final savedToken = await secureStorage.read(key: 'token');
        print('🔥 SAVED TOKEN: $savedToken');

        emit(LoginSuccess(token));
      },
    );
  }
}
