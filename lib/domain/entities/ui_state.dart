import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state.freezed.dart';

/// Entity representing the UI state of the application
@freezed
class UiState with _$UiState {
  const factory UiState({
    // Loading state
    @Default(false) bool isLoading,
    String? loadingMessage,

    // Error dialog state
    @Default(false) bool showErrorDialog,
    String? errorMessage,
    String? errorTitle,

    // Success message state
    @Default(false) bool showSuccessMessage,
    String? successMessage,

    // Info message state
    @Default(false) bool showInfoMessage,
    String? infoMessage,

    // Confirmation dialog state
    @Default(false) bool showConfirmationDialog,
    String? confirmationMessage,
    String? confirmationTitle,
    String? confirmationConfirmText,
    String? confirmationCancelText,

    // Tutorial overlay state
    @Default(false) bool showTutorialOverlay,
    String? tutorialKey,
    String? tutorialContent,

    // Achievement notification state
    @Default(false) bool showAchievementNotification,
    String? achievementTitle,
    String? achievementDescription,

    // Level up notification state
    @Default(false) bool showLevelUpNotification,
    int? levelUpNewLevel,

    // Battle result screen state
    @Default(false) bool showBattleResultScreen,
    bool? battleResultIsVictory,
    int? battleResultScore,
    String? battleResultMessage,
    List<String>? battleResultRewards,

    // Screen visibility state
    @Default(false) bool showSettingsScreen,
    @Default(false) bool showInventoryScreen,
    @Default(false) bool showAchievementScreen,
    @Default(false) bool showStatisticsScreen,

    // Navigation state
    @Default(0) int bottomNavIndex,
    @Default('home') String currentScreen,

    // Settings state
    @Default(false) bool isDebugMode,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(true) bool soundEffectsEnabled,
    @Default(true) bool musicEnabled,
    @Default(0.8) double soundVolume,
    @Default(0.6) double musicVolume,
    @Default(true) bool hapticFeedbackEnabled,
    @Default(1.0) double animationSpeed,
  }) = _UiState;
}

/// Theme mode enumeration
enum ThemeMode {
  system,
  light,
  dark,
}
