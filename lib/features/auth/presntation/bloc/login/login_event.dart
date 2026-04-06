abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String login;
  final String password;

  LoginSubmitted({required this.login, required this.password});
}
