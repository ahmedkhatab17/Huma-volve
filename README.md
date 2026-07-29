# Recipe App - Day 3 Task: Cubit State Management

Flutter application with Cubit state management, API integration, category filtering, error handling, and search.

## Screenshots

| Pick a Category | Pasta Category | Dessert Category |
| :---: | :---: | :---: |
| ![Pick Category](screenshots/initial_pick_category.jpg) | ![Pasta Category](screenshots/pasta_category.jpg) | ![Dessert Category](screenshots/dessert_category.jpg) |

## Features

- **Cubit State Management:** Replaced FutureBuilder with `RecipeHomeCubit` and `BlocBuilder` using `flutter_bloc`.
- **Sealed States:** Implemented sealed `RecipeHomeState` classes (`Initial`, `Loading`, `Failure`, `CategoriesSuccess`, `MealsSuccess`).
- **Category Filter:** Dynamic category fetching and meal filtering by category.
- **Error Handling:** Functional error handling using `Either<Failure, T>` from Dartz and Dio HTTP client.
- **Search & UI:** Instant search filter, skeleton loading, and custom error states with retry.

## How to Run

```bash
flutter pub get
flutter run
```
