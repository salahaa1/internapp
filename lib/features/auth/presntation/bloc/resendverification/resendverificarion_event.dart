abstract class ResendVerificationEvent {}

class ResendVerificationSubmitted extends ResendVerificationEvent {
  final String email;

  ResendVerificationSubmitted({required this.email});
}
