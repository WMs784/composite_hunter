import 'package:flutter/material.dart';
import '../../flutter_gen/gen_l10n/app_localizations.dart';
import 'route_names.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/tutorial/tutorial_screen.dart';
import '../screens/stage/stage_select_screen.dart';
import '../screens/stage/stage_item_selection_screen.dart';
import '../screens/battle/battle_screen.dart';
import '../screens/stage/stage_clear_screen.dart';
import '../screens/inventory/inventory_screen.dart';
import '../screens/achievement/achievement_screen.dart';
import '../../domain/entities/stage.dart';
import '../../domain/entities/stage_info.dart';

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

      case RouteNames.stageItemSelection:
        final stage = settings.arguments as StageInfo;
        return MaterialPageRoute(
          builder: (_) => StageItemSelectionScreen(stage: stage),
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
}

class _UnknownScreen extends StatelessWidget {
  const _UnknownScreen();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.unknownRoute)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              l10n.unknownRoute,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.unknownRouteMessage,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
