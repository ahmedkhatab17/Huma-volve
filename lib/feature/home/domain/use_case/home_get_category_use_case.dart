import 'package:dartz/dartz.dart';
import 'package:recipy_app_offline/core/error/failure.dart';
import 'package:recipy_app_offline/feature/home/domain/entity/home_category_entity.dart';
import 'package:recipy_app_offline/feature/home/domain/repository/home_repository.dart';

class HomeGetCategoryUseCase {
  final HomeRepository repository;
  const HomeGetCategoryUseCase(this.repository);

  Future<Either<Failure, (List<CategoryEntity>, bool)>> invoke() {
    return repository.getCategories();
  }
}
