class PasswordWrongException implements Exception {
  PasswordWrongException(this.message);

  String message;

  @override
  String toString() {
    return message;
  }
}

class NoAccountException implements Exception {
  NoAccountException(this.message);

  String message;

  @override
  String toString() {
    return message;
  }
}

class InvalidEmailException implements Exception {
  InvalidEmailException(this.message);

  String message;

  @override
  String toString() {
    return message;
  }
}

class EmailNotVerifiedException implements Exception {
  EmailNotVerifiedException(this.message);

  String message;

  @override
  String toString() {
    return message;
  }
}

class UserDisabledException implements Exception {
  UserDisabledException(this.message);

  String message;

  @override
  String toString() {
    return message;
  }
}

class UnknownException implements Exception {
  UnknownException(this.message);

  String message;

  @override
  String toString() {
    return message;
  }
}

class AuthRefusedException implements Exception {
  AuthRefusedException(this.message);

  String message;
}

class DownloadFailedException implements Exception {
  DownloadFailedException(this.message);

  String message;

  @override
  String toString() {
    return message;
  }
}
