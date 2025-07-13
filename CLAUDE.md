# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter project called "Composite Hunter" (合成数ハンター) - an educational game that teaches prime factorization through strategic battle gameplay. Players fight composite number enemies using prime numbers as weapons.

## Common Development Commands

### Build and Run
```bash
# Run in development mode
flutter run

# Build for Android
flutter build apk

# Build for iOS
flutter build ios

# Run on specific device
flutter run -d <device-id>
```

### Code Quality
```bash
# Analyze code (lint and type checking)
flutter analyze

# Format code
flutter format .
dart format .

# Run tests
flutter test

# Run widget tests
flutter test test/widget_test.dart

# Run integration tests (if any)
flutter test integration_test/
```

### Dependencies
```bash
# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Clean build artifacts
flutter clean
```

## Architecture Overview

This project follows a layered architecture pattern with clear separation of concerns:

### Directory Structure
```
lib/
├── main.dart                 # App entry point
├── core/                     # Shared utilities and constants
│   ├── constants/           # App-wide constants
│   ├── exceptions/          # Custom exceptions
│   ├── extensions/          # Dart extensions
│   └── utils/               # Utility functions
├── data/                    # Data layer
│   ├── models/             # Data models
│   ├── repositories/       # Data repositories
│   └── datasources/        # Local storage, SharedPreferences
├── domain/                  # Business logic layer
│   ├── entities/           # Business entities
│   ├── usecases/           # Use cases
│   └── services/           # Business services
└── presentation/            # UI layer
    ├── providers/          # State management (Riverpod)
    ├── screens/            # Screen widgets
    ├── widgets/            # Reusable widgets
    └── theme/              # App theming
```

### Key Design Patterns

1. **State Management**: Uses Riverpod for state management with StateNotifier pattern
2. **Clean Architecture**: Separates concerns across data, domain, and presentation layers
3. **Repository Pattern**: Abstracts data sources behind repository interfaces
4. **Strategy Pattern**: Used for enemy generation and battle logic

### Core Game Mechanics

- **Prime Number Combat**: Players attack composite numbers with prime factors
- **Timer System**: Time-limited battles with penalties for escapes/wrong claims
- **Victory Declaration**: Players must manually declare victory when enemy becomes prime
- **Power Enemies**: Special enemies that are prime powers (e.g., 2³, 3², 5²) with bonus rewards
- **Inventory System**: Players collect and manage prime numbers

### Key Components

1. **BattleEngine**: Core battle logic and attack processing
2. **TimerManager**: Handles countdown timers and penalties
3. **EnemyGenerator**: Creates appropriate enemies based on player level
4. **PowerEnemyDetector**: Identifies and creates power enemies
5. **VictoryValidator**: Validates player victory claims

## Important Implementation Notes

### Flutter-Specific Considerations
- Uses Material Design for UI components
- Implements proper Flutter lifecycle management
- Follows Flutter's widget composition patterns
- Uses proper async/await for animations and state updates

### Mathematics Implementation
- Prime number calculations must be efficient for numbers up to 10,000
- Factorization algorithms should handle composite numbers quickly
- Prime validation is critical for game balance

### Educational Focus
- The game teaches prime factorization through gameplay
- Error handling should be educational rather than punitive
- UI should clearly show mathematical relationships

### Performance Requirements
- Battle calculations must complete within 0.5 seconds
- Timer updates must be precise and not cause UI lag
- Memory usage should remain stable during extended play

## Testing Strategy

When writing tests, focus on:
1. **Unit tests**: Core mathematical functions (prime checking, factorization)
2. **Widget tests**: UI components and user interactions
3. **Integration tests**: Complete battle flows and state management

## Development Workflow

1. Always run `flutter analyze` before committing
2. Use `flutter format .` to maintain consistent code style
3. Test on both Android and iOS when possible
4. Run `flutter clean` when experiencing build issues

## Configuration Files

- `pubspec.yaml`: Dependencies and project configuration
- `analysis_options.yaml`: Linting rules (uses package:flutter_lints/flutter.yaml)
- `android/`: Android-specific configuration
- `ios/`: iOS-specific configuration
- `docs/`: Comprehensive project documentation in Japanese

## Documentation

The project includes extensive documentation in Japanese:
- `docs/requirements.md`: Complete requirements specification
- `docs/architecture.md`: Detailed architecture design
- `docs/detailed_class_design.md`: Class-level design specifications
- `docs/database_design.md`: Data persistence design

These documents provide comprehensive context for the game's educational goals, technical architecture, and implementation details.