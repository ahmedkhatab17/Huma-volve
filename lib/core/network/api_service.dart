import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:reciepe_app/core/error/error_handler.dart';
import 'package:reciepe_app/core/error/failure.dart';
import 'package:reciepe_app/feature/meal_details/data/model/meal_detail_model.dart';

class ApiService {
  final dio = Dio(
    BaseOptions(
      // connectTimeout: ,
      // receiveTimeout: Duration(milliseconds: 1),
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
          if (options.path.contains('/posts')) {
            return false;
          }
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
  }
  Future<Either<Failure, MealDetailModel>> getMealDetails(String mealId) async {
    try {
      final response = await dio.get(
        "/lookup.php",
        queryParameters: {"i": mealId},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final jsonRes = response.data["meals"] as List;
        if (jsonRes.isNotEmpty) {
          return right(MealDetailModel.fromJson(jsonRes.first));
        } else {
          throw Exception("Meal details not found");
        }
      } else {
        throw Exception("Something went wrong");
      }
    } on DioException catch (e) {
      final failure = HandleError.handle(e);
      return left(failure);
    }
  }
}
