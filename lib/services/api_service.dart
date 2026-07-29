import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciepe_app/error/error_handler.dart';
import 'package:reciepe_app/error/failure.dart';
import 'package:reciepe_app/models/category_model.dart';
import 'package:reciepe_app/widgets/recipe_card.dart';

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
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.next(options),
        onResponse: (response, handler) => handler.next(response),
        onError: (error, handler) => handler.next(error),
      ),
    );
  }

  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final response = await dio.get("/categories.php");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final jsonRes = response.data["categories"] as List;
        final modelRes = jsonRes
            .map(((e) => CategoryModel.fromJson(e)))
            .toList();
        return right(modelRes);
      } else {
        throw Exception("Something went wrong");
      }
    } on DioException catch (e) {
      final failure = HandleError.handle(e);
      return left(failure);
    }
  }

  Future<Either<Failure, List<Meal>>> getMealsByCategory(
    String category,
  ) async {
    try {
      final response = await dio.get(
        "/filter.php",
        queryParameters: {"c": category},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final jsonRes = response.data["meals"];
        if (jsonRes == null) {
          return right(<Meal>[]);
        }
        final meals = (jsonRes as List)
            .map((e) => Meal.fromJson(e))
            .toList();
        return right(meals);
      } else {
        throw Exception("Something went wrong");
      }
    } on DioException catch (e) {
      final failure = HandleError.handle(e);
      return left(failure);
    }
  }
}
