abstract class DeleteAccountEvent {}

class DeleteAccountSubmitted extends DeleteAccountEvent {
  final String password;

  DeleteAccountSubmitted({required this.password});
}
