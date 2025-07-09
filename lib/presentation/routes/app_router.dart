import 'package:flutter/material.dart';
import 'route_names.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/tutorial/tutorial_screen.dart';
import '../screens/stage/stage_select_screen.dart';
import '../screens/battle/battle_screen.dart';
import '../screens/stage/stage_clear_screen.dart';
import '../screens/inventory/inventory_screen.dart';
import '../screens/achievement/achievement_screen.dart';
import '../../domain/entities/stage.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case RouteNames.tutorial:
        return MaterialPageRoute(
          builder: (_) => const TutorialScreen(),
          settings: settings,
        );

      case RouteNames.stageSelect:
        return MaterialPageRoute(
          builder: (_) => const StageSelectScreen(),
          settings: settings,
        );

      case RouteNames.battle:
        return MaterialPageRoute(
          builder: (_) => const BattleScreen(),
          settings: settings,
        );

      case RouteNames.stageClear:
        final clearResult = settings.arguments as StageClearResult;
        return MaterialPageRoute(
          builder: (_) => StageClearScreen(clearResult: clearResult),
          settings: settings,
        );

      case RouteNames.inventory:
        return MaterialPageRoute(
          builder: (_) => const InventoryScreen(),
          settings: settings,
        );

      case RouteNames.achievement:
        return MaterialPageRoute(
          builder: (_) => const AchievementScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const _UnknownScreen(),
          settings: settings,
        );
    }
  }

  // Navigation helper methods
  static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.pushReplacementNamed<T, TO>(
      context,
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }

  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }

  // Specific navigation methods for the app
  static Future<void> goToTutorial(BuildContext context) {
    return pushReplacementNamed(context, RouteNames.tutorial);
  }

  static Future<void> goToStageSelect(BuildContext context) {
    return pushReplacementNamed(context, RouteNames.stageSelect);
  }

  static Future<void> goToBattle(BuildContext context) {
    return pushReplacementNamed(context, RouteNames.battle);
  }

  static Future<void> goToInventory(BuildContext context) {
    return pushNamed(context, RouteNames.inventory);
  }

  static Future<void> goToAchievements(BuildContext context) {
    return pushNamed(context, RouteNames.achievement);
  }

  static Future<void> goToBattleFromAnywhere(BuildContext context) {
    return pushNamedAndRemoveUntil(
      context,
      RouteNames.battle,
      (route) => false, // Remove all previous routes
    );
  }
}

class _UnknownScreen extends StatelessWidget {
  const _UnknownScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unknown Route'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              'Unknown Route',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'The requested page could not be found.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}