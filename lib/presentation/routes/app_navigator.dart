import 'package:flutter/widgets.dart';
import '../../domain/entities/stage_info.dart';
import 'route_names.dart';

/// 画面遷移のヘルパー。画面を import しないので、どの画面からも使える。
/// （ルート名から画面を組み立てるのは AppRouter）
class AppNavigator {
  // Navigation helper methods
  static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
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

  static Future<void> goToStageItemSelection(
    BuildContext context,
    StageInfo stage,
  ) {
    return pushNamed(context, RouteNames.stageItemSelection, arguments: stage);
  }
}
