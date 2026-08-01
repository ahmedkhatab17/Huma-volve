import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipy_app_offline/core/constants/app_colors.dart';
import 'package:recipy_app_offline/feature/home/presentation/view_model/recipe_home_cubit.dart';
import 'package:recipy_app_offline/feature/home/presentation/view_model/recipe_home_state.dart';
import 'package:recipy_app_offline/feature/home/presentation/widgets/custom_app_bar.dart';
import 'package:recipy_app_offline/feature/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:recipy_app_offline/feature/home/presentation/widgets/custom_search_bar.dart';
import 'package:recipy_app_offline/feature/home/presentation/widgets/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<RecipeHomeCubit>().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Recipes',
        onMenuPressed: () {},
        onProfilePressed: () {},
      ),
      body: BlocBuilder<RecipeHomeCubit, RecipeHomeState>(
        builder: (context, state) {
          if (state is RecipeHomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.accentOrange),
            );
          }

          if (state is RecipeHomeFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off_rounded,
                        size: 64, color: AppColors.navUnselected),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 15),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentOrange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      onPressed: () =>
                          context.read<RecipeHomeCubit>().fetchCategories(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is RecipeHomeSuccess) {
            final categories = state.categories;
            final meals = state.meals;

            return Column(
              children: [
                // ── Offline banner ─────────────────────────────────────────
                if (state.isFromCache)
                  Container(
                    width: double.infinity,
                    color: AppColors.accentOrange.withValues(alpha: 0.15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    child: const Row(
                      children: [
                        Icon(Icons.wifi_off_rounded,
                            size: 16, color: AppColors.accentOrange),
                        SizedBox(width: 8),
                        Text(
                          'Showing cached data — you are offline',
                          style: TextStyle(
                              color: AppColors.accentOrange,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                // ── Search ─────────────────────────────────────────────────
                CustomSearchBar(
                  hintText: 'Search recipes...',
                  onChanged: (_) {},
                ),

                // ── Category chips ─────────────────────────────────────────
                SizedBox(
                  height: 45,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: categories.length,
                    separatorBuilder: (_, i) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final item = categories[index];
                      final isSelected = _selectedCategoryIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedCategoryIndex = index);
                          context
                              .read<RecipeHomeCubit>()
                              .getMealsByCategory(item.strCategory);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.accentOrange
                                : AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.accentOrange
                                  : AppColors.subtleBorder,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? AppColors.accentOrange.withValues(alpha: 0.25)
                                    : AppColors.cardShadow,
                                blurRadius: isSelected ? 6 : 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              item.strCategory,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.primaryBrown,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                                fontSize: 13.5,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                // ── Meal grid ──────────────────────────────────────────────
                Expanded(
                  child: meals.isEmpty
                      ? const Center(
                          child: Text(
                            'No meals found',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: meals.length,
                          itemBuilder: (context, index) {
                            return RecipeCard(meal: meals[index]);
                          },
                        ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentNavIndex,
        onItemTapped: (index) => setState(() => _currentNavIndex = index),
      ),
    );
  }
}
