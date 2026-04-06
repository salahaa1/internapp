abstract class VerifyEmailState {}

class VerifyEmailInitial extends VerifyEmailState {}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailSuccess extends VerifyEmailState {
  final String message;

  VerifyEmailSuccess(this.message);
}

class VerifyEmailWrongCode extends VerifyEmailState {
  final String message;

  VerifyEmailWrongCode(this.message);
}

class VerifyEmailExpiredCode extends VerifyEmailState {
  final String message;

  VerifyEmailExpiredCode(this.message);
}

class VerifyEmailError extends VerifyEmailState {
  final String message;

  VerifyEmailError(this.message);
}
