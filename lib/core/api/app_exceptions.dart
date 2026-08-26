abstract class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException([String message = 'No internet connection available.'])
    : super(message);
}

class ServerException extends AppException {
  ServerException([String message = 'Server error. Please try again later.'])
    : super(message);
}

class NotFoundException extends AppException {
  NotFoundException([String message = 'Data not found in database.'])
    : super(message);
}

class UnknownException extends AppException {
  UnknownException([String message = 'Something went wrong. Please try again.'])
    : super(message);
}
class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Invalid or inactive API Key.'])
      : super(message);
}