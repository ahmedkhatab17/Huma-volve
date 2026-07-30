import 'package:flutter/material.dart';
import 'package:reciepe_app/core/constants/app_colors.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_meal_entity.dart';
import 'package:reciepe_app/feature/meal_details/domain/entity/meal_detail_entity.dart';
import 'package:reciepe_app/feature/meal_details/presentation/widgets/category_area_chip.dart';
import 'package:reciepe_app/feature/meal_details/presentation/widgets/ingredients_section.dart';
import 'package:reciepe_app/feature/meal_details/presentation/widgets/instructions_section.dart';
import 'package:reciepe_app/feature/meal_details/presentation/widgets/meal_details_sliver_app_bar.dart';

class MealDetailsSuccessView extends StatelessWidget {
  final MealEntity initialMeal;
  final MealDetailEntity mealDetail;

  const MealDetailsSuccessView({
    super.key,
    required this.initialMeal,
    required this.mealDetail,
  });

  @override
  Widget build(BuildContext context) {
    final title = mealDetail.strMeal.isNotEmpty
        ? mealDetail.strMeal
        : initialMeal.strMeal;
    final image = mealDetail.strMealThumb.isNotEmpty
        ? mealDetail.strMealThumb
        : initialMeal.strMealThumb;

    return CustomScrollView(
      slivers: [
        MealDetailsSliverAppBar(title: title, imageUrl: image),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (mealDetail.strCategory.isNotEmpty)
                      CategoryAreaChip(
                        icon: Icons.restaurant_menu_rounded,
                        label: mealDetail.strCategory,
                      ),
                    if (mealDetail.strCategory.isNotEmpty &&
                        mealDetail.strArea.isNotEmpty)
                      const SizedBox(width: 8),
                    if (mealDetail.strArea.isNotEmpty)
                      CategoryAreaChip(
                        icon: Icons.public_rounded,
                        label: mealDetail.strArea,
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                IngredientsSection(ingredients: mealDetail.ingredients),
                InstructionsSection(instructions: mealDetail.strInstructions),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
