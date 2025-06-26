@@ -0,0 +1,53 @@
# 📮 PostsApp

A simple Flutter application that displays user posts using the JSONPlaceholder API. The app supports **local caching** with **sqflite**, and is built using **Clean Architecture** principles.

---

## ✨ Features

- 🔄 Fetches posts from the internet.
- 💾 Caches data locally using SQLite.
- 📡 Displays cached data when offline.
- 🧱 Follows Clean Architecture structure.
- 📱 Simple and responsive UI built with Flutter.

---

## 🧱 Clean Architecture Layers

The project is divided into 3 main layers:

1. **Presentation Layer**:
   - Responsible for the UI.
   - Uses `Bloc` for state management.

2. **Domain Layer**:
   - Contains `UseCases`, `Entities`, and abstract `Repositories`.

3. **Data Layer**:
   - Includes:
     - `RemoteDataSource`: Fetches data from the internet.
     - `LocalDataSource`: Handles local caching.
     - `Models`: Transforms data between layers.
     - `RepositoryImpl`: Implements the business logic.

---

## 💾 Local Caching with SQLite

- The app uses **sqflite** to cache posts locally after the first fetch.
- On the next app launch, data is loaded from the local database if no internet connection is available.
- The caching is implemented in `LocalDataSourceImpl`.

---

## 🚀 Getting Started

1. Make sure Flutter is installed on your system.
2. Clone or download the repository.Add commentMore actions
3. Run the following commands:

```bash
flutter pub get
flutter run
