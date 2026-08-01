import 'package:recipy_app_offline/core/local/hive_cache_service.dart';
import 'package:recipy_app_offline/feature/home/data/data_sources/home_data_source.dart';
import 'package:recipy_app_offline/feature/home/data/model/category_model.dart';
import 'package:recipy_app_offline/feature/home/data/model/meal_model.dart';

/// Implements [HomeDataSource] by reading from the Hive local cache.
/// Throws [CacheException] if the box is empty for the requested key.
class HomeLocalDataSourceImp implements HomeDataSource {
  final HiveCacheService _cacheService;
  HomeLocalDataSourceImp(this._cacheService);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final cached = _cacheService.getCategories();
    if (cached == null || cached.isEmpty) {
      throw CacheException('No cached categories found.');
    }
    return cached.map(CategoryModel.fromJson).toList();
  }

  @override
  Future<List<MealModel>> getMealsByCategory(String category) async {
    final cached = _cacheService.getMeals(category);
    if (cached == null || cached.isEmpty) {
      throw CacheException('No cached meals found for "$category".');
    }
    return cached.map(MealModel.fromJson).toList();
  }
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}
