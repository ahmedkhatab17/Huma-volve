import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/feature/meal_details/domain/use_case/get_meal_details_use_case.dart';
import 'package:reciepe_app/feature/meal_details/presentation/view_model/meal_details_state.dart';

class MealDetailsCubit extends Cubit<MealDetailsState> {
  final GetMealDetailsUseCase getMealDetailsUseCase;

  MealDetailsCubit(this.getMealDetailsUseCase, super.initialState);

  Future<void> fetchMealDetails(String mealId) async {
    emit(MealDetailsLoading());
    final result = await getMealDetailsUseCase.invoke(mealId);
    result.fold(
      (failure) => emit(MealDetailsFailure(failure.errorMessage)),
      (mealDetail) => emit(MealDetailsSuccess(mealDetail)),
    );
  }
}
