import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../routes/app_router.dart';

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
                  _buildWelcomePage(),
                  _buildBasicConceptPage(),
                  _buildAttackMechanicsPage(),
                  _buildVictoryConditionPage(),
                  _buildTimerAndPenaltiesPage(),
                ],
              ),
            ),
            
            // Navigation buttons
            _buildNavigationButtons(),
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
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.spacingXs),
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

  Widget _buildWelcomePage() {
    return _TutorialPage(
      title: 'Welcome to\nComposite Hunter!',
      content: 'Learn prime factorization through exciting battles with composite numbers.',
      icon: Icons.calculate,
      iconColor: AppColors.primary,
    );
  }

  Widget _buildBasicConceptPage() {
    return _TutorialPage(
      title: 'Prime vs Composite',
      content: 'Prime numbers (2, 3, 5, 7...) can only be divided by 1 and themselves.\n\nComposite numbers (4, 6, 8, 9...) can be divided by other numbers.',
      icon: Icons.numbers,
      iconColor: AppColors.secondary,
      example: '12 = 2 × 2 × 3',
    );
  }

  Widget _buildAttackMechanicsPage() {
    return _TutorialPage(
      title: 'Attack with Primes',
      content: 'Use your prime numbers to attack composite enemies.\n\nIf a prime divides the enemy, the enemy\'s value becomes smaller!',
      icon: Icons.gps_fixed,
      iconColor: AppColors.victoryGreen,
      example: '12 ÷ 2 = 6\n6 ÷ 2 = 3\n3 is prime!',
    );
  }

  Widget _buildVictoryConditionPage() {
    return _TutorialPage(
      title: 'Claim Victory',
      content: 'When you reduce an enemy to a prime number, press "Claim Victory!"\n\nBe careful - wrong claims cost you time!',
      icon: Icons.emoji_events,
      iconColor: AppColors.victoryGreen,
      example: 'Enemy becomes prime?\nClaim Victory! ✓',
    );
  }

  Widget _buildTimerAndPenaltiesPage() {
    return _TutorialPage(
      title: 'Time Pressure',
      content: 'Each battle has a time limit!\n\n• Escaping: -10 seconds next battle\n• Wrong claim: -10 seconds immediately\n• Timeout: -10 seconds next battle',
      icon: Icons.timer,
      iconColor: AppColors.timerWarning,
      example: 'Fight smart and fast!',
      isLastPage: true,
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingM),
      child: Row(
        children: [
          if (_currentPage > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousPage,
                child: const Text('Previous'),
              ),
            ),
          
          if (_currentPage > 0)
            const SizedBox(width: Dimensions.spacingM),
          
          Expanded(
            flex: _currentPage == 0 ? 1 : 2,
            child: ElevatedButton(
              onPressed: _nextPage,
              child: Text(
                _currentPage == _totalPages - 1 ? 'Start Playing!' : 'Next',
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
  final bool isLastPage;

  const _TutorialPage({
    required this.title,
    required this.content,
    required this.icon,
    required this.iconColor,
    this.example,
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
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Dimensions.radiusXl),
            ),
            child: Icon(
              icon,
              size: 60,
              color: iconColor,
            ),
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
                color: AppColors.victoryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Dimensions.radiusM),
                border: Border.all(color: AppColors.victoryGreen),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: AppColors.victoryGreen,
                  ),
                  const SizedBox(width: Dimensions.spacingS),
                  Text(
                    'Ready to hunt some composite numbers?',
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