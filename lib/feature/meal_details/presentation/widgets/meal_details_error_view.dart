import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/core/constants/app_colors.dart';
import 'package:reciepe_app/feature/meal_details/presentation/view_model/meal_details_cubit.dart';
import 'package:reciepe_app/feature/meal_details/presentation/widgets/meal_details_sliver_app_bar.dart';

class MealDetailsErrorView extends StatelessWidget {
  final String mealTitle;
  final String imageUrl;
  final String mealId;
  final String errorMessage;

  const MealDetailsErrorView({
    super.key,
    required this.mealTitle,
    required this.imageUrl,
    required this.mealId,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        MealDetailsSliverAppBar(
          title: mealTitle,
          imageUrl: imageUrl,
        ),
        SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: AppColors.errorRed,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<MealDetailsCubit>()
                          .fetchMealDetails(mealId);
                    },
                    child: const Text(
                      'Retry',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
