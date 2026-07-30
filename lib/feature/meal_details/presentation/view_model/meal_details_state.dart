import 'package:reciepe_app/feature/meal_details/domain/entity/meal_detail_entity.dart';

abstract class MealDetailsState {}

class MealDetailsInitial extends MealDetailsState {}

class MealDetailsLoading extends MealDetailsState {}

class MealDetailsSuccess extends MealDetailsState {
  final MealDetailEntity mealDetail;
  MealDetailsSuccess(this.mealDetail);
}

class MealDetailsFailure extends MealDetailsState {
  final String errorMessage;
  MealDetailsFailure(this.errorMessage);
}
