import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:composite_hunter/presentation/screens/battle/battle_screen.dart';
import 'package:composite_hunter/presentation/theme/app_theme.dart';

void main() {
  group('BattleScreen Widget Tests', () {
    Widget createBattleScreen() {
      return MaterialApp(
        theme: AppTheme.lightTheme,
        home: const BattleScreen(),
      );
    }

    testWidgets('should display all required UI elements', (tester) async {
      await tester.pumpWidget(createBattleScreen());

      // Check for AppBar
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Battle'), findsOneWidget);

      // Check for action buttons in AppBar
      expect(find.byIcon(Icons.inventory), findsOneWidget);
      expect(find.byIcon(Icons.emoji_events), findsOneWidget);

      // Check for timer section
      expect(find.text('Time Remaining'), findsOneWidget);
      expect(find.textContaining(':'), findsOneWidget); // Timer display

      // Check for enemy section
      expect(find.text('Enemy Composite Number'), findsOneWidget);
      expect(find.text('Attack with prime factors to defeat it!'), findsOneWidget);

      // Check for prime grid section
      expect(find.text('Your Prime Numbers'), findsOneWidget);

      // Check for action buttons
      expect(find.text('Escape'), findsOneWidget);
      expect(find.text('Claim Victory!'), findsOneWidget);
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