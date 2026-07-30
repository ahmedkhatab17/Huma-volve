import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/core/constants/app_colors.dart';
import 'package:reciepe_app/core/network/api_service.dart';
import 'package:reciepe_app/feature/home/data/data_sources/home_data_source.dart';
import 'package:reciepe_app/feature/home/data/data_sources/home_remote_data_source_imp.dart';
import 'package:reciepe_app/feature/home/data/repository/home_repository_imp.dart';
import 'package:reciepe_app/feature/home/domain/repository/home_repository.dart';
import 'package:reciepe_app/feature/home/domain/use_case/home_get_category_use_case.dart';
import 'package:reciepe_app/feature/home/domain/use_case/home_get_meals_use_case.dart';
import 'package:reciepe_app/feature/home/presentation/view_model/recipe_home_cubit.dart';
import 'package:reciepe_app/feature/home/presentation/view_model/recipe_home_state.dart';
import 'package:reciepe_app/feature/home/presentation/view/recipe_home_screen.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    final HomeDataSource homeDataSource = HomeRemoteDataSourceImp(apiService);
    final HomeRepository homeRepository = HomeRepositoryImp(homeDataSource);
    final HomeGetCategoryUseCase homeGetCategoryUseCase = HomeGetCategoryUseCase(homeRepository);
    final HomeGetMealsUseCase homeGetMealsUseCase = HomeGetMealsUseCase(homeRepository,);
    final RecipeHomeCubit recipeHomeCubit = RecipeHomeCubit(homeGetCategoryUseCase,homeGetMealsUseCase,RecipeHomeInitial(),);
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBrown,
          surface: AppColors.background,
        ),
        fontFamily: 'Roboto',
      ),
      // home: const SeafoodScreen(),
      home: BlocProvider(
        create: (context) => recipeHomeCubit ,
        child: HomeScreen(),
      ),
    );
  }
}
