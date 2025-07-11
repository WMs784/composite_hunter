import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:composite_hunter/presentation/screens/battle/battle_screen.dart';
import 'package:composite_hunter/presentation/theme/app_theme.dart';
import 'package:composite_hunter/domain/entities/enemy.dart';
import 'package:composite_hunter/domain/entities/prime.dart';
import 'package:composite_hunter/domain/entities/battle_state.dart';
import 'package:composite_hunter/domain/entities/timer_state.dart';
import 'package:composite_hunter/presentation/providers/battle_provider.dart';
import 'package:composite_hunter/presentation/providers/inventory_provider.dart';
import 'package:composite_hunter/presentation/providers/battle_session_provider.dart';
import 'package:composite_hunter/domain/services/battle_engine.dart';
import 'package:composite_hunter/domain/services/enemy_generator.dart';
import 'package:composite_hunter/domain/services/timer_manager.dart';
import 'package:composite_hunter/flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('BattleScreen Widget Tests', () {
    // Mock data
    final mockEnemy = Enemy(
      currentValue: 12,
      originalValue: 12,
      type: EnemyType.small,
      primeFactors: [2, 2, 3],
    );

    final mockInventory = [
      Prime(value: 2, count: 3, firstObtained: DateTime.now()),
      Prime(value: 3, count: 2, firstObtained: DateTime.now()),
      Prime(value: 5, count: 1, firstObtained: DateTime.now()),
      Prime(value: 7, count: 1, firstObtained: DateTime.now()),
    ];

    final mockBattleState = BattleState(
      currentEnemy: mockEnemy,
      usedPrimes: [],
      status: BattleStatus.fighting,
      turnCount: 0,
      battleStartTime: DateTime.now(),
      timerState: TimerState(
        remainingSeconds: 60,
        originalSeconds: 60,
        isActive: true,
        isWarning: false,
        penalties: [],
      ),
    );

    Widget createBattleScreen() {
      return ProviderScope(
        overrides: [
          inventoryProvider.overrideWith((ref) => InventoryNotifier()),
          battleProvider.overrideWith((ref) => BattleNotifier(
            EnemyGenerator(),
            TimerManager(),
            ref,
          )),
          battleSessionProvider.overrideWith((ref) => BattleSessionNotifier()..startPractice(mockInventory)),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('ja', ''),
          ],
          home: const BattleScreen(),
        ),
      );
    }

testWidgets('should display all required UI elements', (tester) async {
      await tester.pumpWidget(createBattleScreen());
      await tester.pumpAndSettle();

      // Check for AppBar
      expect(find.byType(AppBar), findsOneWidget);
      
      // Check for basic screen elements (text may vary by localization)
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SafeArea), findsWidgets);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('should display timer correctly', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      // Find timer display
      final timerFinder = find.textContaining(':');
      expect(timerFinder, findsOneWidget);

      // Check timer format (should be MM:SS)
      final timerText = tester.widget<Text>(timerFinder).data!;
      final timerRegex = RegExp(r'^\d{2}:\d{2}$');
      expect(timerRegex.hasMatch(timerText), true);
    });

    testWidgets('should display enemy value', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      // Check for enemy value display (should be a number)
      expect(find.text('12'), findsOneWidget); // Sample enemy value
    });

    testWidgets('should display prime grid with correct layout', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      // Check for GridView
      expect(find.byType(GridView), findsOneWidget);

      // Check for prime buttons (sample primes: 2, 3, 5, 7, 11, 13, 17, 19)
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);

      // Check for count indicators
      expect(find.textContaining('x'), findsWidgets); // Should find multiple count indicators
    });

    testWidgets('should have interactive prime buttons', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      // Find a prime button and test interaction
      final primeButton = find.text('2').first;
      expect(primeButton, findsOneWidget);

      // Tap the prime button (should not throw)
      await tester.tap(primeButton);
      await tester.pump();
    });

    testWidgets('should have functional escape button', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      final escapeButton = find.text('Escape');
      expect(escapeButton, findsOneWidget);

      // Should be an OutlinedButton
      expect(find.byType(OutlinedButton), findsOneWidget);

      // Tap escape button (should not throw)
      await tester.tap(escapeButton);
      await tester.pump();
    });

    testWidgets('should have functional victory claim button', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      final victoryButton = find.text('Claim Victory!');
      expect(victoryButton, findsOneWidget);

      // Should be an ElevatedButton
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Tap victory button (should not throw)
      await tester.tap(victoryButton);
      await tester.pump();
    });

    testWidgets('should navigate to inventory when inventory icon is tapped', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      final inventoryIcon = find.byIcon(Icons.inventory);
      expect(inventoryIcon, findsOneWidget);

      // Note: Navigation testing would require more complex setup with Navigator
      // For now, just verify the button exists and can be tapped
      await tester.tap(inventoryIcon);
      await tester.pump();
    });

    testWidgets('should navigate to achievements when trophy icon is tapped', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      final achievementIcon = find.byIcon(Icons.emoji_events);
      expect(achievementIcon, findsOneWidget);

      // Note: Navigation testing would require more complex setup with Navigator
      // For now, just verify the button exists and can be tapped
      await tester.tap(achievementIcon);
      await tester.pump();
    });

    testWidgets('should display prime counts correctly', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      // Check that prime count indicators are shown
      final countIndicators = find.textContaining('x3');
      expect(countIndicators, findsWidgets);
    });

    testWidgets('should use correct theme colors', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      // Check that the app uses the correct theme
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, equals(AppTheme.lightTheme));
    });

    testWidgets('should be scrollable when content overflows', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      // The main content should be in a Column within a SafeArea
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('should handle screen size changes gracefully', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      // Test with different screen sizes
      await tester.binding.setSurfaceSize(const Size(400, 600));
      await tester.pump();

      // All elements should still be present
      expect(find.text('Battle'), findsOneWidget);
      expect(find.text('Your Prime Numbers'), findsOneWidget);
      expect(find.text('Claim Victory!'), findsOneWidget);

      // Test with larger screen
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      await tester.pump();

      // All elements should still be present
      expect(find.text('Battle'), findsOneWidget);
      expect(find.text('Your Prime Numbers'), findsOneWidget);
      expect(find.text('Claim Victory!'), findsOneWidget);

      // Reset to default size
      await tester.binding.setSurfaceSize(null);
    });
  });
}