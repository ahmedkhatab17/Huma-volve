import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipy_app_offline/core/constants/app_colors.dart';
import 'package:recipy_app_offline/core/local/hive_cache_service.dart';
import 'package:recipy_app_offline/core/network/api_service.dart';
import 'package:recipy_app_offline/feature/home/data/data_sources/home_local_data_source_imp.dart';
import 'package:recipy_app_offline/feature/home/data/data_sources/home_remote_data_source_imp.dart';
import 'package:recipy_app_offline/feature/home/data/repository/home_repository_imp.dart';
import 'package:recipy_app_offline/feature/home/domain/repository/home_repository.dart';
import 'package:recipy_app_offline/feature/home/domain/use_case/home_get_category_use_case.dart';
import 'package:recipy_app_offline/feature/home/domain/use_case/home_get_meals_use_case.dart';
import 'package:recipy_app_offline/feature/home/presentation/view/home_screen.dart';
import 'package:recipy_app_offline/feature/home/presentation/view_model/recipe_home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Hive init ─────────────────────────────────────────────────────────────
  await Hive.initFlutter();
  final hiveCacheService = await HiveCacheService.init();

  // ── Dependency wiring ──────────────────────────────────────────────────────
  final apiService = ApiService();
  final remote = HomeRemoteDataSourceImp(apiService);
  final local = HomeLocalDataSourceImp(hiveCacheService);
  final HomeRepository homeRepository = HomeRepositoryImp(
    remote: remote,
    local: local,
    cache: hiveCacheService,
  );
  final homeGetCategoryUseCase = HomeGetCategoryUseCase(homeRepository);
  final homeGetMealsUseCase = HomeGetMealsUseCase(homeRepository);

  runApp(
    RecipeApp(
      cubit: RecipeHomeCubit(homeGetCategoryUseCase, homeGetMealsUseCase),
    ),
  );
}

class RecipeApp extends StatelessWidget {
  final RecipeHomeCubit cubit;
  const RecipeApp({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App — Offline First',
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
      home: BlocProvider.value(
        value: cubit,
        child: const HomeScreen(),
      ),
    );
  }
}
