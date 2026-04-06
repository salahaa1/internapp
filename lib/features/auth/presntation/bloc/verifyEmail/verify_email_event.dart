abstract class VerifyEmailEvent {}

class VerifyEmailSubmitted extends VerifyEmailEvent {
  final String email;
  final String code;

  VerifyEmailSubmitted({required this.email, required this.code});
}
