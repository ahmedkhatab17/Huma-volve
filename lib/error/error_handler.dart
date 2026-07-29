import 'package:dio/dio.dart';

import 'failure.dart';

class HandleError {
  static Failure handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Failure("Connection timed out. Please try again.");

      case DioExceptionType.sendTimeout:
        return Failure("Request took too long to send.");

      case DioExceptionType.receiveTimeout:
        return Failure("Server took too long to respond.");

      case DioExceptionType.badResponse:
        return Failure(_handleStatusCode(error.response?.statusCode));

      case DioExceptionType.connectionError:
        return Failure("No internet connection. Please check your network.");

      case DioExceptionType.cancel:
        return Failure("Request has been cancelled.");

      default:
        return Failure("Something went wrong. Please try again.");
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad request. Please try again.";

      case 401:
        return "You are not authorized.";

      case 403:
        return "Access denied.";

      case 404:
        return "Requested resource was not found.";

      case 500:
        return "Internal server error. Please try again later.";

      case 502:
        return "Bad gateway. Please try again later.";

      case 503:
        return "Service is currently unavailable.";

      default:
        return "Unexpected server error.";
    }
  }
}