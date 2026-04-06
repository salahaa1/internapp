abstract class ResendVerificationState {}

class ResendVerificationInitial extends ResendVerificationState {}

class ResendVerificationLoading extends ResendVerificationState {}

class ResendVerificationSuccess extends ResendVerificationState {
  final String message;

  ResendVerificationSuccess(this.message);
}

class ResendVerificationError extends ResendVerificationState {
  final String message;

  ResendVerificationError(this.message);
}
