# Recipe App - Day 2 Task

Flutter application with API integration, category filtering, error handling, and search.

## Screenshots

| Pick a Category | Pasta Category | Dessert Category |
| :---: | :---: | :---: |
| ![Pick Category](screenshots/initial_pick_category.jpg) | ![Pasta Category](screenshots/pasta_category.jpg) | ![Dessert Category](screenshots/dessert_category.jpg) |

## Features

- **Category Filter:** Fetch categories dynamically and filter recipes.
- **Error Handling:** Dio client error handling using `Either<Failure, T>` from Dartz.
- **Search:** Instant search filtering per category.
- **Loading & UI:** Skeleton loading and clean error states.

## How to Run

```bash
flutter pub get
flutter run
```
