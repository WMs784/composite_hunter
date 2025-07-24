import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';
import '../../../flutter_gen/gen_l10n/app_localizations.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeTutorial();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeTutorial() {
    // TODO: Mark tutorial as completed in preferences
    AppRouter.goToStageSelect(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            _buildProgressIndicator(),

            // Tutorial content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _buildWelcomePage(l10n),
                  _buildBasicConceptPage(l10n),
                  _buildAttackMechanicsPage(l10n),
                  _buildVictoryConditionPage(l10n),
                  _buildTimerAndPenaltiesPage(l10n),
                ],
              ),
            ),

            // Navigation buttons
            _buildNavigationButtons(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_totalPages, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: Dimensions.spacingXs,
            ),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index <= _currentPage
                  ? AppColors.primary
                  : AppColors.surfaceVariant,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildWelcomePage(AppLocalizations l10n) {
    return _TutorialPage(
      title: l10n.tutorialWelcomeTitle,
      content: l10n.tutorialWelcomeContent,
      icon: Icons.calculate,
      iconColor: AppColors.primary,
    );
  }

  Widget _buildBasicConceptPage(AppLocalizations l10n) {
    return _TutorialPage(
      title: l10n.tutorialBasicTitle,
      content: l10n.tutorialBasicContent,
      icon: Icons.numbers,
      iconColor: AppColors.secondary,
      example: l10n.tutorialBasicExample,
    );
  }

  Widget _buildAttackMechanicsPage(AppLocalizations l10n) {
    return _TutorialPage(
      title: l10n.tutorialAttackTitle,
      content: l10n.tutorialAttackContent,
      icon: Icons.gps_fixed,
      iconColor: AppColors.victoryGreen,
      example: l10n.tutorialAttackExample,
    );
  }

  Widget _buildVictoryConditionPage(AppLocalizations l10n) {
    return _TutorialPage(
      title: l10n.tutorialVictoryTitle,
      content: l10n.tutorialVictoryContent,
      icon: Icons.emoji_events,
      iconColor: AppColors.victoryGreen,
      example: l10n.tutorialVictoryExample,
    );
  }

  Widget _buildTimerAndPenaltiesPage(AppLocalizations l10n) {
    return _TutorialPage(
      title: l10n.tutorialTimerTitle,
      content: l10n.tutorialTimerContent,
      icon: Icons.timer,
      iconColor: AppColors.timerWarning,
      example: l10n.tutorialTimerExample,
      readyMessage: l10n.tutorialReadyMessage,
      isLastPage: true,
    );
  }

  Widget _buildNavigationButtons(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingM),
      child: Row(
        children: [
          if (_currentPage > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousPage,
                child: Text(l10n.previous),
              ),
            ),
          if (_currentPage > 0) const SizedBox(width: Dimensions.spacingM),
          Expanded(
            flex: _currentPage == 0 ? 1 : 2,
            child: ElevatedButton(
              onPressed: _nextPage,
              child: Text(
                _currentPage == _totalPages - 1 ? l10n.startPlaying : l10n.next,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TutorialPage extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color iconColor;
  final String? example;
  final String? readyMessage;
  final bool isLastPage;

  const _TutorialPage({
    required this.title,
    required this.content,
    required this.icon,
    required this.iconColor,
    this.example,
    this.readyMessage,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Dimensions.radiusXl),
            ),
            child: Icon(icon, size: 60, color: iconColor),
          ),

          const SizedBox(height: Dimensions.spacingXl),

          // Title
          Text(
            title,
            style: AppTextStyles.headlineMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: Dimensions.spacingL),

          // Content
          Text(
            content,
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),

          if (example != null) ...[
            const SizedBox(height: Dimensions.spacingL),
            Container(
              padding: const EdgeInsets.all(Dimensions.paddingM),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(Dimensions.radiusM),
              ),
              child: Text(
                example!,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.onPrimaryContainer,
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],

          if (isLastPage) ...[
            const SizedBox(height: Dimensions.spacingXl),
            Container(
              padding: const EdgeInsets.all(Dimensions.paddingM),
              decoration: BoxDecoration(
                color: AppColors.victoryGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Dimensions.radiusM),
                border: Border.all(color: AppColors.victoryGreen),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lightbulb, color: AppColors.victoryGreen),
                  const SizedBox(width: Dimensions.spacingS),
                  Text(
                    readyMessage ?? 'Ready to hunt some composite numbers?',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.victoryGreen,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
