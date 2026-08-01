# 🍽️ Recipe App — Offline First

A Flutter recipe app built with **Clean Architecture** that works completely offline using **Hive** local cache.

## 📌 What We Did

Implemented an **Offline-First Home Screen** on top of a clean architecture recipe app.

### Key Concept — Offline-First Strategy

Every network call follows this flow:

```
Network call
    ✅ Success  →  Save to Hive cache  →  Show data
    ❌ Fail     →  Read from Hive cache →  Show data (with offline banner)
    ❌ No cache →  Show error + retry
```

### What Was Built

| Layer | Added |
|---|---|
| **Core** | `HiveCacheService` — thin Hive wrapper, stores JSON strings, no code-gen |
| **Data** | `HomeLocalDataSourceImp` — implements `HomeDataSource` from Hive |
| **Data** | `HomeRepositoryImp` — offline-first logic (network first, fallback to cache) |
| **Domain** | Return type uses **Dart 3 records** `(data, isFromCache)` — zero new classes |
| **Presentation** | Orange offline banner shown when data is served from Hive |

### Packages Used
- `hive_flutter` — local key-value storage
- `dio` + `pretty_dio_logger` — HTTP client
- `flutter_bloc` — state management (Cubit)
- `dartz` — functional `Either<Failure, T>` result type

## 🏗️ Architecture

```
lib/
├── core/
│   ├── constants/        # AppColors
│   ├── error/            # Failure, HandleError
│   ├── local/            # HiveCacheService ← NEW
│   └── network/          # ApiService (Dio)
└── feature/home/
    ├── data/
    │   ├── data_sources/ # Remote + Local implementations ← NEW
    │   ├── model/        # CategoryModel, MealModel (with toJson for cache)
    │   └── repository/   # Offline-first HomeRepositoryImp ← MODIFIED
    ├── domain/           # Entities, use cases, repository interface
    └── presentation/     # Cubit, states, HomeScreen, widgets
```

## 🚀 How to Run

```bash
flutter pub get
flutter run
```

> First launch must be **online** to populate the Hive cache.  
> After that, the app works fully **offline**.
