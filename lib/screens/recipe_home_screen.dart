import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/constants/app_colors.dart';
import 'package:reciepe_app/cubit/recipe_home_cubit.dart';
import 'package:reciepe_app/cubit/recipe_home_state.dart';
import 'package:reciepe_app/models/meal_model.dart';
import 'package:reciepe_app/services/api_service.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/recipe_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/filter_header_row.dart';

class SeafoodScreen extends StatelessWidget {
  const SeafoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecipeHomeCubit(ApiService())..fetchCategories(),
      child: const _RecipeHomeView(),
    );
  }
}

class _RecipeHomeView extends StatefulWidget {
  const _RecipeHomeView();

  @override
  State<_RecipeHomeView> createState() => _RecipeHomeViewState();
}

class _RecipeHomeViewState extends State<_RecipeHomeView> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  String _searchQuery = '';
  int _currentNavIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MealModel> _filtered(List<MealModel> meals) {
    if (_searchQuery.isEmpty) return meals;
    return meals
        .where(
          (m) => m.strMeal.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  Widget _buildSkeletonCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: const AspectRatio(
            aspectRatio: 1.1,
            child: _ShimmerBox(width: double.infinity, height: double.infinity),
          ),
        ),
        const SizedBox(height: 8),
        const _ShimmerBox(width: 120, height: 14),
        const SizedBox(height: 4),
        const _ShimmerBox(width: 80, height: 12),
      ],
    );
  }

  Widget _buildSkeletonChips() {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, index) => _ShimmerBox(
          width: 72 + (index % 3) * 16.0,
          height: 32,
          radius: 20,
        ),
      ),
    );
  }

  Widget _buildCategoryChips(RecipeHomeCubit cubit) {
    final categories = cubit.categories;

    if (categories.isEmpty) return _buildSkeletonChips();

    return SizedBox(
      height: 56,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final name = category.strCategory ?? '';
          final isSelected = _selectedCategory == name;

          return ChoiceChip(
            label: Text(name),
            selected: isSelected,
            onSelected: (_) {
              setState(() {
                _selectedCategory = name;
                _searchQuery = '';
                _searchController.clear();
              });
              cubit.fetchMeals(name);
            },
            selectedColor: AppColors.chipSelected,
            backgroundColor: AppColors.surface,
            side: BorderSide(
              color:
                  isSelected ? AppColors.chipSelected : AppColors.subtleBorder,
            ),
            labelStyle: TextStyle(
              color:
                  isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight:
                  isSelected ? FontWeight.w700 : FontWeight.w400,
              fontSize: 13,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          );
        },
      ),
    );
  }

  Widget _buildBody(RecipeHomeState state, RecipeHomeCubit cubit) {
    // While loading (categories first time or meals)
    if (state is RecipeHomeLoading) {
      if (cubit.categories.isEmpty) {
        // First load — skeleton for chips + grid
        return Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 14,
              mainAxisSpacing: 16,
            ),
            itemCount: 8,
            itemBuilder: (_, _) => _buildSkeletonCard(),
          ),
        );
      }
      // Categories already loaded, loading meals → skeleton grid
      return Expanded(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72,
            crossAxisSpacing: 14,
            mainAxisSpacing: 16,
          ),
          itemCount: 8,
          itemBuilder: (_, _) => _buildSkeletonCard(),
        ),
      );
    }

    // Error state
    if (state is RecipeHomeFailure) {
      return Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.errorRed.withAlpha(20),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.wifi_off_rounded,
                    size: 40,
                    color: AppColors.errorRed,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBrown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_selectedCategory != null) {
                      cubit.fetchMeals(_selectedCategory!);
                    } else {
                      cubit.fetchCategories();
                    }
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text(
                    'Try Again',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Categories loaded — show prompt to pick one
    if (state is RecipeHomeCategoriesSuccess) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.restaurant_menu_rounded,
                  size: 44,
                  color: AppColors.primaryBrown,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Pick a category',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Tap a chip above to explore recipes',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    // Meals loaded
    if (state is RecipeHomeMealsSuccess) {
      final meals = _filtered(state.meals);

      if (meals.isEmpty) {
        return Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.no_meals_outlined,
                    size: 40,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _searchQuery.isNotEmpty
                      ? 'No results for "$_searchQuery"'
                      : 'No recipes found',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Expanded(
        child: Column(
          children: [
            FilterHeaderRow(count: meals.length),
            Expanded(
              child: GridView.builder(
                padding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 16,
                ),
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                    meal: meals[index],
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${meals[index].strMeal}'),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: AppColors.primaryBrown,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    // Initial state (before fetchCategories completes)
    return const Expanded(child: SizedBox.shrink());
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RecipeHomeCubit>();

    return BlocBuilder<RecipeHomeCubit, RecipeHomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF2F0EB),
          appBar: CustomAppBar(
            title: _selectedCategory ?? 'Recipes',
            onMenuPressed: () {},
            onProfilePressed: () {},
          ),
          body: Column(
            children: [
              CustomSearchBar(
                controller: _searchController,
                hintText: _selectedCategory != null
                    ? 'Search in $_selectedCategory...'
                    : 'Search recipes...',
                onChanged: (query) => setState(() => _searchQuery = query),
              ),
              _buildCategoryChips(cubit),
              _buildBody(state, cubit),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _currentNavIndex,
            onItemTapped: (index) =>
                setState(() => _currentNavIndex = index),
          ),
        );
      },
    );
  }
}

class _ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final double radius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    this.radius = 8,
  });

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, _) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColors.shimmerBase.withValues(alpha: _anim.value),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}
