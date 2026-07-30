import 'package:reciepe_app/core/network/api_service.dart';
import 'package:reciepe_app/feature/home/data/data_sources/home_data_source.dart';
import 'package:reciepe_app/feature/home/data/model/category_model.dart';
import 'package:reciepe_app/feature/home/data/model/meal_model.dart';

class HomeRemoteDataSourceImp implements HomeDataSource {
  ApiService apiService;
  HomeRemoteDataSourceImp(this.apiService);

  late final dio = apiService.dio;

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.get("/categories.php");
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final jsonRes = response.data["categories"] as List;
      final modelRes = jsonRes.map(((e) => CategoryModel.fromJson(e))).toList();
      return modelRes;
    } else {
      final errorMessage = response.data["message"];
      throw Exception(errorMessage);
    }
  }

  @override
  Future<List<MealModel>> getMealsByCategory(String category) async {
    final response = await dio.get(
      "/filter.php",
      queryParameters: {"c": category},
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.data["meals"] == null) {
        return [];
      }
      final jsonRes = response.data["meals"] as List;
      final modelRes = jsonRes.map(((e) => MealModel.fromJson(e))).toList();
      return modelRes;
    } else {
      final errorMessage = response.data["message"];
      throw Exception(errorMessage);
    }
  }
}

  // Future<Either<Failure, List<CategoryModel>>> getCategories() async {
  //   try {
  //     final response = await dio.get("/categories.php");
  //     if (response.statusCode! >= 200 && response.statusCode! < 300) {
  //       final jsonRes = response.data["categories"] as List;
  //       final modelRes = jsonRes
  //           .map(((e) => CategoryModel.fromJson(e)))
  //           .toList();
  //       return right(modelRes);
  //     } else {
  //       throw Exception("Something went wrong");
  //     }
  //   } on DioException catch (e) {
  //     final failure = HandleError.handle(e);
  //     return left(failure);
  //   }
  // }

  // Future<Either<Failure, List<MealModel>>> getMealsByCategory(
  //   String category,
  // ) async {
  //   try {
  //     final response = await dio.get(
  //       "/filter.php",
  //       queryParameters: {"c": category},
  //     );
  //     if (response.statusCode! >= 200 && response.statusCode! < 300) {
  //       if (response.data["meals"] == null) {
  //         return right([]);
  //       }
  //       final jsonRes = response.data["meals"] as List;
  //       final modelRes = jsonRes.map(((e) => MealModel.fromJson(e))).toList();
  //       return right(modelRes);
  //     } else {
  //       throw Exception("Something went wrong");
  //     }
  //   } on DioException catch (e) {
  //     final failure = HandleError.handle(e);
  //     return left(failure);
  //   }
  // }