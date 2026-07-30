import 'package:flutter/material.dart';
import 'package:reciepe_app/core/constants/app_colors.dart';
import 'package:reciepe_app/feature/meal_details/presentation/widgets/meal_details_sliver_app_bar.dart';

class MealDetailsLoadingView extends StatelessWidget {
  final String mealTitle;
  final String imageUrl;

  const MealDetailsLoadingView({
    super.key,
    required this.mealTitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        MealDetailsSliverAppBar(
          title: mealTitle,
          imageUrl: imageUrl,
        ),
        const SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryBrown,
            ),
          ),
        ),
      ],
    );
  }
}
