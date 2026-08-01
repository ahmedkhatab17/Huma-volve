import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:recipy_app_offline/core/error/error_handler.dart';
import 'package:recipy_app_offline/core/error/failure.dart';
import 'package:recipy_app_offline/core/local/hive_cache_service.dart';
import 'package:recipy_app_offline/feature/home/data/data_sources/home_data_source.dart';
import 'package:recipy_app_offline/feature/home/data/data_sources/home_local_data_source_imp.dart';
import 'package:recipy_app_offline/feature/home/domain/entity/home_category_entity.dart';
import 'package:recipy_app_offline/feature/home/domain/entity/home_meal_entity.dart';
import 'package:recipy_app_offline/feature/home/domain/repository/home_repository.dart';

/// Offline-first strategy:
///   1. Try network first
///   2. On success  → persist to Hive → return (data, isFromCache: false)
///   3. On DioException → fallback to Hive → return (data, isFromCache: true)
///   4. Cache also empty → return Failure
class HomeRepositoryImp implements HomeRepository {
  final HomeDataSource _remote;
  final HomeLocalDataSourceImp _local;
  final HiveCacheService _cache;

  HomeRepositoryImp({
    required HomeDataSource remote,
    required HomeLocalDataSourceImp local,
    required HiveCacheService cache,
  })  : _remote = remote,
        _local = local,
        _cache = cache;

  // ── categories ────────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, (List<CategoryEntity>, bool)>> getCategories() async {
    try {
      final models = await _remote.getCategories();
      await _cache.saveCategories(models.map((m) => m.toJson()).toList());
      return right((models.map((m) => m.toEntity()).toList(), false));
    } on DioException catch (e) {
      try {
        final models = await _local.getCategories();
        return right((models.map((m) => m.toEntity()).toList(), true));
      } on CacheException {
        return left(HandleError.handle(e));
      }
    }
  }

  // ── meals ─────────────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, (List<MealEntity>, bool)>> getMealsByCategory(
      String category) async {
    try {
      final models = await _remote.getMealsByCategory(category);
      await _cache.saveMeals(category, models.map((m) => m.toJson()).toList());
      return right((models.map((m) => m.toEntity()).toList(), false));
    } on DioException catch (e) {
      try {
        final models = await _local.getMealsByCategory(category);
        return right((models.map((m) => m.toEntity()).toList(), true));
      } on CacheException {
        return left(HandleError.handle(e));
      }
    }
  }
}
