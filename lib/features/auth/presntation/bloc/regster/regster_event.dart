abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String mobileNo;

  RegisterSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.mobileNo,
  });
}
