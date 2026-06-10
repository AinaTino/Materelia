// auth_exception.dart

sealed class AuthFieldException implements Exception {
  final String message;
  const AuthFieldException(this.message);
  
  @override
  String toString() => message;
}

class EmailErrorException extends AuthFieldException {
  const EmailErrorException(super.message);
}

class PasswordErrorException extends AuthFieldException {
  const PasswordErrorException(super.message);
}

class FirstNameErrorException extends AuthFieldException {
  const FirstNameErrorException(super.message);
}

class NameErrorException extends AuthFieldException {
  const NameErrorException(super.message);
}