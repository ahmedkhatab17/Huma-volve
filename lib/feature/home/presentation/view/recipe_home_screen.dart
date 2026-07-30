import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/core/network/api_service.dart';
import 'package:reciepe_app/feature/meal_details/data/data_sources/meal_details_remote_data_source_imp.dart';
import 'package:reciepe_app/feature/meal_details/data/repository/meal_details_repository_imp.dart';
import 'package:reciepe_app/feature/meal_details/domain/use_case/get_meal_details_use_case.dart';
import 'package:reciepe_app/feature/home/presentation/view_model/recipe_home_cubit.dart';
import 'package:reciepe_app/feature/home/presentation/view_model/recipe_home_state.dart';
import 'package:reciepe_app/feature/meal_details/presentation/view_model/meal_details_cubit.dart';
import 'package:reciepe_app/feature/meal_details/presentation/view_model/meal_details_state.dart';
import 'package:reciepe_app/feature/meal_details/presentation/view/meal_details_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_search_bar.dart';
import 'package:reciepe_app/feature/meal_details/presentation/widgets/recipe_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 1;
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
        title: 'Seafood',
        onMenuPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Menu tapped')));
        },
        onProfilePressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Profile tapped')));
        },
      ),
      body: BlocBuilder<RecipeHomeCubit, RecipeHomeState>(
        builder: (context, state) {
          if (state is RecipeHomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecipeHomeFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is RecipeHomeSuccess) {
            final categories = state.categories;
            final meals = state.meals;

            return Column(
              children: [
                CustomSearchBar(
                  hintText: 'Search in Seafood',
                  onChanged: (query) {
                    setState(() {
                      // _searchQuery = query;
                    });
                  },
                ),
                SizedBox(
                  height: 45,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final item = categories[index];
                      final isSelected = _selectedCategoryIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                          context
                              .read<RecipeHomeCubit>()
                              .getMealsByCategory(item.strCategory);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.accentOrange
                                : AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.accentOrange
                                  : AppColors.subtleBorder,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? AppColors.accentOrange.withValues(
                                        alpha: 0.25,
                                      )
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
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: categories.length,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      final meal = meals[index];
                      return RecipeCard(
                        onTap: () {
                          if (meal.idMeal.isNotEmpty) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      MealDetailsCubit(
                                        GetMealDetailsUseCase(
                                          MealDetailsRepositoryImp(
                                            MealDetailsRemoteDataSourceImp(
                                              ApiService(),
                                            ),
                                          ),
                                        ),
                                        MealDetailsInitial(),
                                      )..fetchMealDetails(meal.idMeal),
                                  child: MealDetailsScreen(meal: meal),
                                ),
                              ),
                            );
                          }
                        },
                        meal: meal,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("Unexpected Error"));
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentNavIndex,
        onItemTapped: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }
}
