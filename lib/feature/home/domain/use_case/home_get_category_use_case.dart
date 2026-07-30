import 'package:dartz/dartz.dart';
import 'package:reciepe_app/core/error/failure.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_category_entity.dart';
import 'package:reciepe_app/feature/home/domain/repository/home_repository.dart';

class HomeGetCategoryUseCase {
  final HomeRepository repository;
  HomeGetCategoryUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> invoke() async {
    return await repository.getCategories();
  }
}
