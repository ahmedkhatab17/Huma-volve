import 'package:flutter/material.dart';
import 'package:recipy_app_offline/core/constants/app_colors.dart';
import 'package:recipy_app_offline/feature/home/domain/entity/home_meal_entity.dart';

class RecipeCard extends StatelessWidget {
  final MealEntity meal;
  final VoidCallback? onTap;

  const RecipeCard({super.key, required this.meal, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: meal.strMealThumb.isNotEmpty
                    ? Image.network(
                        meal.strMealThumb,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (_, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            color: AppColors.subtleBorder,
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.accentOrange,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (_, e, s) => Container(
                          color: AppColors.subtleBorder,
                          child: const Icon(
                            Icons.broken_image_outlined,
                            color: AppColors.navUnselected,
                          ),
                        ),
                      )
                    : Container(
                        color: AppColors.subtleBorder,
                        child: const Icon(Icons.fastfood_outlined,
                            color: AppColors.navUnselected),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                meal.strMeal,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
