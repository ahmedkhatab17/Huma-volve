import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://www.themealdb.com/api/json/v1/1",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  );

  ApiService() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
  }
}
