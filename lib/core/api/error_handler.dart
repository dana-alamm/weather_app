import 'package:dio/dio.dart';

class ErrorHandler {
  static String handle(dynamic error)  {
    if(error is DioException){
      switch(error.type){
     case DioExceptionType.connectionTimeout:
     case DioExceptionType.sendTimeout:
     case DioExceptionType.receiveTimeout:
     return 'Connection timed out. Please check your internet and try again.';

     case DioExceptionType.badResponse:
     final statusCode=error.response?.statusCode;
     switch (statusCode){
      case 400:
      return 'Bad request. Please check the provided location.';
            case 401:
              return 'Invalid API key or unauthorized access.';
            case 404:
              return 'City or requested data not found.';
            case 429:
              return 'API rate limit exceeded. Please try again later.';
            case 500:
            case 502:
            case 503:
              return 'Server error. Please try again later.';
            default:
              return 'Received invalid status code: $statusCode';
     }
     case DioExceptionType.connectionError:
          return 'No internet connection. Please check your network.';

        case DioExceptionType.cancel:
          return 'Request was cancelled.';

        default:
          return 'An unexpected network error occurred.';

      }
    }
    return error.toString();
  }
}