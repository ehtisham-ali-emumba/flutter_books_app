# Books

A minimal Flutter app for browsing and managing books.

## Architecture

- **MVVM** (Model-View-ViewModel) pattern for separation of concerns.
- **Provider** for state management.
- **Repository** layer for data access (API/local).

## Libraries

- `provider` — State management
- `http` — Networking
- `flutter/material.dart` — UI components

## Getting Started

1. Run `flutter pub get`
2. Run `flutter run`

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Features

- Browse bestseller, sci-fi, and history book collections
- Search for books by title, author, or keywords
- View detailed book information
- Add books to favorites
- Write and manage book reviews
- Customizable app theme with light/dark mode support
- Responsive UI for various device sizes

## Architecture

The app follows a clean architecture approach with:
- **BLoC/Cubit Pattern** for state management
- **Repository Pattern** for data handling
- **Dependency Injection** for service locator
- **Feature-F

## API Integration

The app integrates with the Open Library API to fetch book information and covers.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
