import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/core/constants/app_colors.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_meal_entity.dart';
import 'package:reciepe_app/feature/meal_details/presentation/view_model/meal_details_cubit.dart';
import 'package:reciepe_app/feature/meal_details/presentation/view_model/meal_details_state.dart';
import 'package:reciepe_app/feature/meal_details/presentation/widgets/meal_details_error_view.dart';
import 'package:reciepe_app/feature/meal_details/presentation/widgets/meal_details_loading_view.dart';
import 'package:reciepe_app/feature/meal_details/presentation/widgets/meal_details_success_view.dart';

class MealDetailsScreen extends StatelessWidget {
  final MealEntity meal;

  const MealDetailsScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final mealTitle = meal.strMeal;
    final imageUrl = meal.strMealThumb;
    final mealId = meal.idMeal;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<MealDetailsCubit, MealDetailsState>(
        builder: (context, state) {
          if (state is MealDetailsLoading) {
            return MealDetailsLoadingView(
              mealTitle: mealTitle,
              imageUrl: imageUrl,
            );
          } else if (state is MealDetailsFailure) {
            return MealDetailsErrorView(
              mealTitle: mealTitle,
              imageUrl: imageUrl,
              mealId: mealId,
              errorMessage: state.errorMessage,
            );
          } else if (state is MealDetailsSuccess) {
            return MealDetailsSuccessView(
              initialMeal: meal,
              mealDetail: state.mealDetail,
            );
          }
          return MealDetailsLoadingView(
            mealTitle: mealTitle,
            imageUrl: imageUrl,
          );
        },
      ),
    );
  }
}
