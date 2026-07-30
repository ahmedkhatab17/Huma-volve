# Recipy App — Day 4 Task

## Changes Made: Meal Details Feature — Clean Arch Alignment

Refactored the `meal_details` feature to fully match the code style and patterns used in the `home` feature.

### 1. `MealDetailModel.fromJson` — Named Constructor

Changed from a `factory` constructor to a **named constructor**, matching `CategoryModel.fromJson` and `MealModel.fromJson` in the home feature.

### 2. `MealDetailsCubit` — Injected Initial State

Changed the cubit constructor to accept `super.initialState` as an external parameter instead of hardcoding `super(MealDetailsInitial())` inside, matching the `RecipeHomeCubit` pattern.

```dart
// Before
MealDetailsCubit(this.getMealDetailsUseCase) : super(MealDetailsInitial());

// After
MealDetailsCubit(this.getMealDetailsUseCase, super.initialState);
```

The caller (`recipe_home_screen.dart`) now passes `MealDetailsInitial()` when creating the cubit.
