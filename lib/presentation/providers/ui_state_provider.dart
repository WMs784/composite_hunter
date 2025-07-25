import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/ui_state.dart';
import '../../core/utils/logger.dart';

/// State notifier for UI state management
class UiStateNotifier extends StateNotifier<UiState> {
  UiStateNotifier() : super(const UiState());

  /// Show loading state
  void showLoading({String? message}) {
    Logger.debug('Showing loading state: ${message ?? "no message"}');
    state = state.copyWith(isLoading: true, loadingMessage: message);
  }

  /// Hide loading state
  void hideLoading() {
    Logger.debug('Hiding loading state');
    state = state.copyWith(isLoading: false, loadingMessage: null);
  }

  /// Show error dialog
  void showError(String message, {String? title}) {
    Logger.debug('Showing error dialog: $message');
    state = state.copyWith(
      showErrorDialog: true,
      errorMessage: message,
      errorTitle: title ?? 'Error',
    );
  }

  /// Hide error dialog
  void hideError() {
    Logger.debug('Hiding error dialog');
    state = state.copyWith(
      showErrorDialog: false,
      errorMessage: null,
      errorTitle: null,
    );
  }

  /// Show success message
  void showSuccess(String message, {Duration? duration}) {
    Logger.debug('Showing success message: $message');
    state = state.copyWith(showSuccessMessage: true, successMessage: message);

    // Auto-hide after duration
    Future.delayed(duration ?? const Duration(seconds: 3), () {
      if (mounted) {
        hideSuccess();
      }
    });
  }

  /// Hide success message
  void hideSuccess() {
    Logger.debug('Hiding success message');
    state = state.copyWith(showSuccessMessage: false, successMessage: null);
  }

  /// Show info message
  void showInfo(String message, {Duration? duration}) {
    Logger.debug('Showing info message: $message');
    state = state.copyWith(showInfoMessage: true, infoMessage: message);

    // Auto-hide after duration
    Future.delayed(duration ?? const Duration(seconds: 4), () {
      if (mounted) {
        hideInfo();
      }
    });
  }

  /// Hide info message
  void hideInfo() {
    Logger.debug('Hiding info message');
    state = state.copyWith(showInfoMessage: false, infoMessage: null);
  }

  /// Show confirmation dialog
  void showConfirmation({
    required String message,
    required String confirmText,
    required String cancelText,
    String? title,
  }) {
    Logger.debug('Showing confirmation dialog: $message');
    state = state.copyWith(
      showConfirmationDialog: true,
      confirmationMessage: message,
      confirmationTitle: title ?? 'Confirm',
      confirmationConfirmText: confirmText,
      confirmationCancelText: cancelText,
    );
  }

  /// Hide confirmation dialog
  void hideConfirmation() {
    Logger.debug('Hiding confirmation dialog');
    state = state.copyWith(
      showConfirmationDialog: false,
      confirmationMessage: null,
      confirmationTitle: null,
      confirmationConfirmText: null,
      confirmationCancelText: null,
    );
  }

  /// Show tutorial overlay
  void showTutorial(String tutorialKey, String content) {
    Logger.debug('Showing tutorial: $tutorialKey');
    state = state.copyWith(
      showTutorialOverlay: true,
      tutorialKey: tutorialKey,
      tutorialContent: content,
    );
  }

  /// Hide tutorial overlay
  void hideTutorial() {
    Logger.debug('Hiding tutorial');
    state = state.copyWith(
      showTutorialOverlay: false,
      tutorialKey: null,
      tutorialContent: null,
    );
  }

  /// Show achievement notification
  void showAchievementUnlocked(String achievementTitle, String description) {
    Logger.debug('Showing achievement notification: $achievementTitle');
    state = state.copyWith(
      showAchievementNotification: true,
      achievementTitle: achievementTitle,
      achievementDescription: description,
    );

    // Auto-hide after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        hideAchievementNotification();
      }
    });
  }

  /// Hide achievement notification
  void hideAchievementNotification() {
    Logger.debug('Hiding achievement notification');
    state = state.copyWith(
      showAchievementNotification: false,
      achievementTitle: null,
      achievementDescription: null,
    );
  }

  /// Show level up notification
  void showLevelUp(int newLevel) {
    Logger.debug('Showing level up notification for level: $newLevel');
    state = state.copyWith(
      showLevelUpNotification: true,
      levelUpNewLevel: newLevel,
    );

    // Auto-hide after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        hideLevelUp();
      }
    });
  }

  /// Hide level up notification
  void hideLevelUp() {
    Logger.debug('Hiding level up notification');
    state = state.copyWith(
      showLevelUpNotification: false,
      levelUpNewLevel: null,
    );
  }

  /// Show battle result screen
  void showBattleResult({
    required bool isVictory,
    required int score,
    required String message,
    List<String>? rewards,
  }) {
    Logger.debug('Showing battle result: victory=$isVictory, score=$score');
    state = state.copyWith(
      showBattleResultScreen: true,
      battleResultIsVictory: isVictory,
      battleResultScore: score,
      battleResultMessage: message,
      battleResultRewards: rewards,
    );
  }

  /// Hide battle result screen
  void hideBattleResult() {
    Logger.debug('Hiding battle result');
    state = state.copyWith(
      showBattleResultScreen: false,
      battleResultIsVictory: null,
      battleResultScore: null,
      battleResultMessage: null,
      battleResultRewards: null,
    );
  }

  /// Show settings screen
  void showSettings() {
    Logger.debug('Showing settings');
    state = state.copyWith(showSettingsScreen: true);
  }

  /// Hide settings screen
  void hideSettings() {
    Logger.debug('Hiding settings');
    state = state.copyWith(showSettingsScreen: false);
  }

  /// Show inventory screen
  void showInventory() {
    Logger.debug('Showing inventory');
    state = state.copyWith(showInventoryScreen: true);
  }

  /// Hide inventory screen
  void hideInventory() {
    Logger.debug('Hiding inventory');
    state = state.copyWith(showInventoryScreen: false);
  }

  /// Show achievement screen
  void showAchievements() {
    Logger.debug('Showing achievements');
    state = state.copyWith(showAchievementScreen: true);
  }

  /// Hide achievement screen
  void hideAchievements() {
    Logger.debug('Hiding achievements');
    state = state.copyWith(showAchievementScreen: false);
  }

  /// Show statistics screen
  void showStatistics() {
    Logger.debug('Showing statistics');
    state = state.copyWith(showStatisticsScreen: true);
  }

  /// Hide statistics screen
  void hideStatistics() {
    Logger.debug('Hiding statistics');
    state = state.copyWith(showStatisticsScreen: false);
  }

  /// Set bottom navigation index
  void setBottomNavIndex(int index) {
    Logger.debug('Setting bottom nav index: $index');
    state = state.copyWith(bottomNavIndex: index);
  }

  /// Set current screen
  void setCurrentScreen(String screenName) {
    Logger.debug('Setting current screen: $screenName');
    state = state.copyWith(currentScreen: screenName);
  }

  /// Toggle debug mode
  void toggleDebugMode() {
    final newDebugMode = !state.isDebugMode;
    Logger.debug('Toggling debug mode: $newDebugMode');
    state = state.copyWith(isDebugMode: newDebugMode);
  }

  /// Set theme mode
  void setThemeMode(ThemeMode mode) {
    Logger.debug('Setting theme mode: ${mode.name}');
    state = state.copyWith(themeMode: mode);
  }

  /// Toggle sound effects
  void toggleSoundEffects() {
    final newSoundEnabled = !state.soundEffectsEnabled;
    Logger.debug('Toggling sound effects: $newSoundEnabled');
    state = state.copyWith(soundEffectsEnabled: newSoundEnabled);
  }

  /// Toggle music
  void toggleMusic() {
    final newMusicEnabled = !state.musicEnabled;
    Logger.debug('Toggling music: $newMusicEnabled');
    state = state.copyWith(musicEnabled: newMusicEnabled);
  }

  /// Set sound volume
  void setSoundVolume(double volume) {
    Logger.debug('Setting sound volume: $volume');
    state = state.copyWith(soundVolume: volume.clamp(0.0, 1.0));
  }

  /// Set music volume
  void setMusicVolume(double volume) {
    Logger.debug('Setting music volume: $volume');
    state = state.copyWith(musicVolume: volume.clamp(0.0, 1.0));
  }

  /// Toggle haptic feedback
  void toggleHapticFeedback() {
    final newHapticEnabled = !state.hapticFeedbackEnabled;
    Logger.debug('Toggling haptic feedback: $newHapticEnabled');
    state = state.copyWith(hapticFeedbackEnabled: newHapticEnabled);
  }

  /// Set animation speed
  void setAnimationSpeed(double speed) {
    Logger.debug('Setting animation speed: $speed');
    state = state.copyWith(animationSpeed: speed.clamp(0.5, 2.0));
  }

  /// Reset all notifications
  void clearAllNotifications() {
    Logger.debug('Clearing all notifications');
    state = state.copyWith(
      showSuccessMessage: false,
      showInfoMessage: false,
      showAchievementNotification: false,
      showLevelUpNotification: false,
      successMessage: null,
      infoMessage: null,
      achievementTitle: null,
      achievementDescription: null,
      levelUpNewLevel: null,
    );
  }

  /// Reset all dialogs
  void clearAllDialogs() {
    Logger.debug('Clearing all dialogs');
    state = state.copyWith(
      showErrorDialog: false,
      showConfirmationDialog: false,
      showTutorialOverlay: false,
      errorMessage: null,
      errorTitle: null,
      confirmationMessage: null,
      confirmationTitle: null,
      confirmationConfirmText: null,
      confirmationCancelText: null,
      tutorialKey: null,
      tutorialContent: null,
    );
  }

  /// Reset all screens
  void clearAllScreens() {
    Logger.debug('Clearing all screens');
    state = state.copyWith(
      showBattleResultScreen: false,
      showSettingsScreen: false,
      showInventoryScreen: false,
      showAchievementScreen: false,
      showStatisticsScreen: false,
      battleResultIsVictory: null,
      battleResultScore: null,
      battleResultMessage: null,
      battleResultRewards: null,
    );
  }

  /// Reset to default state
  void resetToDefault() {
    Logger.debug('Resetting UI state to default');
    state = const UiState();
  }
}

/// UI state provider
final uiStateProvider = StateNotifierProvider<UiStateNotifier, UiState>((ref) {
  return UiStateNotifier();
});

/// Loading state providers
final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).isLoading;
});

final loadingMessageProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).loadingMessage;
});

/// Error state providers
final showErrorDialogProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showErrorDialog;
});

final errorMessageProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).errorMessage;
});

final errorTitleProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).errorTitle;
});

/// Success message providers
final showSuccessMessageProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showSuccessMessage;
});

final successMessageProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).successMessage;
});

/// Info message providers
final showInfoMessageProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showInfoMessage;
});

final infoMessageProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).infoMessage;
});

/// Confirmation dialog providers
final showConfirmationDialogProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showConfirmationDialog;
});

final confirmationMessageProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).confirmationMessage;
});

final confirmationTitleProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).confirmationTitle;
});

/// Tutorial overlay providers
final showTutorialOverlayProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showTutorialOverlay;
});

final tutorialKeyProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).tutorialKey;
});

final tutorialContentProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).tutorialContent;
});

/// Achievement notification providers
final showAchievementNotificationProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showAchievementNotification;
});

final achievementTitleProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).achievementTitle;
});

final achievementDescriptionProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).achievementDescription;
});

/// Level up notification providers
final showLevelUpNotificationProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showLevelUpNotification;
});

final levelUpNewLevelProvider = Provider<int?>((ref) {
  return ref.watch(uiStateProvider).levelUpNewLevel;
});

/// Battle result screen providers
final showBattleResultScreenProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showBattleResultScreen;
});

final battleResultIsVictoryProvider = Provider<bool?>((ref) {
  return ref.watch(uiStateProvider).battleResultIsVictory;
});

final battleResultScoreProvider = Provider<int?>((ref) {
  return ref.watch(uiStateProvider).battleResultScore;
});

final battleResultMessageProvider = Provider<String?>((ref) {
  return ref.watch(uiStateProvider).battleResultMessage;
});

final battleResultRewardsProvider = Provider<List<String>?>((ref) {
  return ref.watch(uiStateProvider).battleResultRewards;
});

/// Screen state providers
final showSettingsScreenProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showSettingsScreen;
});

final showInventoryScreenProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showInventoryScreen;
});

final showAchievementScreenProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showAchievementScreen;
});

final showStatisticsScreenProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).showStatisticsScreen;
});

/// Navigation providers
final bottomNavIndexProvider = Provider<int>((ref) {
  return ref.watch(uiStateProvider).bottomNavIndex;
});

final currentScreenProvider = Provider<String>((ref) {
  return ref.watch(uiStateProvider).currentScreen;
});

/// Settings providers
final isDebugModeProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).isDebugMode;
});

final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(uiStateProvider).themeMode;
});

final soundEffectsEnabledProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).soundEffectsEnabled;
});

final musicEnabledProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).musicEnabled;
});

final soundVolumeProvider = Provider<double>((ref) {
  return ref.watch(uiStateProvider).soundVolume;
});

final musicVolumeProvider = Provider<double>((ref) {
  return ref.watch(uiStateProvider).musicVolume;
});

final hapticFeedbackEnabledProvider = Provider<bool>((ref) {
  return ref.watch(uiStateProvider).hapticFeedbackEnabled;
});

final animationSpeedProvider = Provider<double>((ref) {
  return ref.watch(uiStateProvider).animationSpeed;
});

/// Combined state providers
final hasActiveNotificationProvider = Provider<bool>((ref) {
  final uiState = ref.watch(uiStateProvider);
  return uiState.showSuccessMessage ||
      uiState.showInfoMessage ||
      uiState.showAchievementNotification ||
      uiState.showLevelUpNotification;
});

final hasActiveDialogProvider = Provider<bool>((ref) {
  final uiState = ref.watch(uiStateProvider);
  return uiState.showErrorDialog ||
      uiState.showConfirmationDialog ||
      uiState.showTutorialOverlay;
});

final hasActiveScreenProvider = Provider<bool>((ref) {
  final uiState = ref.watch(uiStateProvider);
  return uiState.showBattleResultScreen ||
      uiState.showSettingsScreen ||
      uiState.showInventoryScreen ||
      uiState.showAchievementScreen ||
      uiState.showStatisticsScreen;
});
