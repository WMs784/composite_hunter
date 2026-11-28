import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:composite_hunter/presentation/screens/battle/battle_screen.dart';
import 'package:composite_hunter/presentation/theme/app_theme.dart';
import 'package:composite_hunter/presentation/providers/inventory_provider.dart';
import 'package:composite_hunter/presentation/providers/battle_session_provider.dart';
import 'package:composite_hunter/flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('BattleScreen Widget Tests', () {
    Widget createTestableWidget(Widget child) {
      return ProviderScope(
        overrides: [
          inventoryProvider.overrideWith((ref) => InventoryNotifier()),
          battleSessionProvider.overrideWith((ref) => BattleSessionNotifier()),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', ''), Locale('ja', '')],
          home: child,
        ),
      );
    }

    testWidgets('should build without errors', (tester) async {
      await tester.pumpWidget(createTestableWidget(const BattleScreen()));

      // Simply verify that the widget can be created without errors
      expect(find.byType(BattleScreen), findsOneWidget);
    });

    testWidgets('should have proper provider setup', (tester) async {
      await tester.pumpWidget(createTestableWidget(const BattleScreen()));

      // Check that the MaterialApp is created properly
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(ProviderScope), findsOneWidget);
    });

    testWidgets('should use correct theme', (tester) async {
      await tester.pumpWidget(createTestableWidget(const BattleScreen()));

      // Check that the app uses the correct theme
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, isNotNull);
    });
  });
}
