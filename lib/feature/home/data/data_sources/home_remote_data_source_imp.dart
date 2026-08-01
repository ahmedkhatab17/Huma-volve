import 'package:recipy_app_offline/core/network/api_service.dart';
import 'package:recipy_app_offline/feature/home/data/data_sources/home_data_source.dart';
import 'package:recipy_app_offline/feature/home/data/model/category_model.dart';
import 'package:recipy_app_offline/feature/home/data/model/meal_model.dart';

class HomeRemoteDataSourceImp implements HomeDataSource {
  final ApiService _apiService;
  HomeRemoteDataSourceImp(this._apiService);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _apiService.dio.get("/categories.php");
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final jsonRes = response.data["categories"] as List;
      return jsonRes
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(response.data["message"]);
    }
  }

  @override
  Future<List<MealModel>> getMealsByCategory(String category) async {
    final response = await _apiService.dio.get(
      "/filter.php",
      queryParameters: {"c": category},
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.data["meals"] == null) return [];
      final jsonRes = response.data["meals"] as List;
      return jsonRes
          .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(response.data["message"]);
    }
  }
}
