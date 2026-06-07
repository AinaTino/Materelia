class EmailErrorException implements FormatException {
  @override
  final String message;

  @override
  String toString() => message;
  
  EmailErrorException(this.message);
  
  @override
  // TODO: implement offset
  int? get offset => throw UnimplementedError();
  
  @override
  // TODO: implement source
  get source => throw UnimplementedError();
}

class PasswordErrorException implements FormatException {
  @override
  final String message;

  @override
  String toString() => message;
  
  PasswordErrorException(this.message);
  
  @override
  // TODO: implement offset
  int? get offset => throw UnimplementedError();
  
  @override
  // TODO: implement source
  get source => throw UnimplementedError();
}

class FirstNameErrorException implements FormatException {
  @override
  final String message;

  @override
  String toString() => message;
  
  FirstNameErrorException(this.message);
  
  @override
  // TODO: implement offset
  int? get offset => throw UnimplementedError();
  
  @override
  // TODO: implement source
  get source => throw UnimplementedError();
}

class NameErrorException implements FormatException {
  @override
  final String message;

  @override
  String toString() => message;
  
  NameErrorException(this.message);
  
  @override
  // TODO: implement offset
  int? get offset => throw UnimplementedError();
  
  @override
  // TODO: implement source
  get source => throw UnimplementedError();
}