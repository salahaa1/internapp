abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(super.message);
}

class NotFoundFailure extends Failure {
  NotFoundFailure(super.message);
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}
