# Eldorado Challenge - Currency Exchange Calculator

> **Enterprise-grade Flutter application** implementing Clean Architecture, MVVM, and Riverpod for scalable cryptocurrency exchange calculations.

[![Tests](https://img.shields.io/badge/tests-%20passing-success)]()
[![Coverage](https://img.shields.io/badge/coverage-all%20layers-blue)]()
[![Architecture](https://img.shields.io/badge/architecture-Clean%20%2B%20MVVM-orange)]()
[![State Management](https://img.shields.io/badge/state-Riverpod-purple)]()

---

## 🏗️ Architecture Overview

This project implements **Clean Architecture** with **MVVM pattern** using **Riverpod** for dependency injection and state management.

```
┌─────────────────────────────────────────────────────────────┐
│                     Presentation Layer                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Screens    │  │  ViewModels  │  │    Widgets   │      │
│  │ (UI/Widgets) │→ │  (Riverpod)  │← │   (Freezed)  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                      Domain Layer                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Entities   │  │  Use Cases   │  │ Repositories │      │
│  │  (Business)  │← │  (Business)  │→ │ (Interfaces) │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                       Data Layer                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │     DTOs     │  │ DataSources  │  │ Repositories │      │
│  │   (Models)   │← │ (API/Cache)  │→ │    (Impl)    │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

### Key Architectural Decisions

| Decision | Rationale |
|----------|-----------|
| **Clean Architecture** | Separation of concerns, testability, independence from frameworks |
| **MVVM** | Clear separation between UI and business logic, reactive patterns |
| **Riverpod** | Compile-time safe DI, better testing, no context dependency |
| **Freezed** | Immutable state, type-safe copyWith, union types |
| **Result Pattern** | Type-safe error handling, no exceptions in business logic |
| **ExceptionMapper** | DRY principle for error handling, single source of truth |

---

## Project Structure

```
lib/
├── core/                           # Shared infrastructure
│   ├── errors/                     # Error handling
│   │   ├── exceptions.dart         # Custom exceptions (Data layer)
│   │   ├── failures.dart           # Business failures (Domain/Presentation)
│   │   └── exception_mapper.dart   # DioException → AppException converter
│   ├── utils/
│   │   └── result.dart             # Result<T> pattern (Success/Failure)
│   ├── models/                     # Shared domain models
│   ├── services/                   # Infrastructure services (Dio, Logger)
│   ├── router/                     # Navigation (GoRouter)
│   ├── theme/                      # App theming
│   └── widgets/                    # Reusable UI components
│
├── features/                       # Feature modules (Clean Architecture)
│   └── exchange/                   # Exchange rate feature
│       ├── domain/                 # Business logic (framework-independent)
│       │   ├── entities/           # Pure business objects
│       │   │   └── exchange_rate_entity.dart
│       │   ├── repositories/       # Repository interfaces
│       │   │   └── exchange_repository.dart
│       │   └── usecases/           # Business use cases
│       │       ├── get_exchange_rate_usecase.dart
│       │       └── validate_exchange_usecase.dart
│       │
│       ├── data/                   # Data implementation
│       │   ├── models/             # DTOs (Data Transfer Objects)
│       │   │   └── exchange_rate_dto.dart
│       │   ├── datasources/        # API/Cache implementations
│       │   │   └── exchange_remote_datasource.dart
│       │   └── repositories/       # Repository implementations
│       │       └── exchange_repository_impl.dart
│       │
│       └── presentation/           # UI layer
│           ├── screens/            # Screen widgets
│           │   └── exchange_screen.dart
│           ├── widgets/            # Feature-specific widgets
│           ├── viewmodels/         # State management (Riverpod)
│           │   ├── exchange_vm.dart
│           │   ├── exchange_dependencies.dart  # DI providers
│           │   └── currency_options_provider.dart
│           ├── state/              # State objects (Freezed)
│           │   └── exchange_state.dart
│           └── helpers/            # UI helpers
│               ├── exchange_validator.dart
│               ├── exchange_calculator.dart
│               └── exchange_ui_helper.dart
│
└── main.dart                       # App entry point (ProviderScope)

test/                               # Mirror structure for tests
├── core/
│   └── utils/
│       └── result_test.dart        
└── features/
    └── exchange/
        ├── domain/
        │   ├── entities/           
        │   └── usecases/           
        ├── data/
        │   └── repositories/       
        └── presentation/
            └── viewmodels/         
```

---

## Testing Strategy

### Test Coverage: **80 tests passing**

| Layer | Tests | Coverage |
|-------|-------|----------|
| **Core** | 29 | Result pattern, generic types, transformations |
| **Domain (Entity)** | 16 | Calculations, validation, formatting |
| **Domain (Use Cases)** | 16 | Business logic, validation, error handling |
| **Data (Repository)** | 8 | Exception→Failure mapping, DTO→Entity |
| **Presentation (ViewModel)** | 11 | State management, user interactions, async flows |

### Test Architecture

```dart
// Example: Testing with Mocktail + Riverpod
test('should update state with recommendation on success', () async {
  // ARRANGE: Setup mocks and state
  when(() => mockGetExchangeRate(...)).thenAnswer((_) async => Success(entity));
  
  // ACT: Execute ViewModel action
  await container.read(exchangeViewModelProvider.notifier).execute();
  
  // ASSERT: Verify state changes
  expect(state.recommendation, equals(entity));
  verify(() => mockGetExchangeRate(...)).called(1);
});
```

### Run Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/exchange/domain/entities/exchange_rate_entity_test.dart

# Analyze test coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## Quick Start

### Prerequisites

- **Flutter SDK**: 3.35.2+
- **Dart SDK**: 3.9.0+

```bash
flutter --version
```

### Installation

```bash
# 1. Install dependencies
flutter pub get

# 2. Generate code (Freezed + Riverpod)
dart run build_runner build --delete-conflicting-outputs

# 3. Run the app
flutter run
```

---

## 🛠️ Tech Stack

### Core Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| **flutter_riverpod** | ^2.6.1 | State management & DI |
| **riverpod_annotation** | ^2.6.1 | Code generation for providers |
| **freezed_annotation** | ^3.1.0 | Immutable state classes |
| **dio** | ^5.7.0 | HTTP client |
| **go_router** | ^14.6.2 | Declarative routing |
| **logger** | ^2.5.0 | Logging |

### Dev Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| **build_runner** | ^2.4.15 | Code generation |
| **riverpod_generator** | ^2.6.5 | Riverpod code gen |
| **freezed** | ^2.6.0 | State code gen |
| **mocktail** | ^1.0.4 | Mocking for tests |
| **flutter_test** | SDK | Testing framework |

---

## Key Features

### Implemented

- [x] **Clean Architecture** with clear layer separation
- [x] **MVVM** with Riverpod ViewModels
- [x] **Type-safe error handling** with Result pattern
- [x] **Immutable state** with Freezed
- [x] **80 unit tests** with Mocktail
- [x] **ExceptionMapper** for DRY error handling
- [x] **Computed properties** for derived state
- [x] **Input validation** with business rules
- [x] **Responsive animations** (Hero, scale, fade)
- [x] **Currency swap** with smooth transitions
- [x] **Real-time calculations** from Eldorado API

### UI/UX Highlights

- Hero animation on app launch (circle → exchange card)
- Smooth currency swap animation with scale effect
- Bottom sheet for currency selection (crypto/fiat tabs)
- Real-time input validation with error messages
- Loading states during API calls
- Success/error feedback with custom widgets
