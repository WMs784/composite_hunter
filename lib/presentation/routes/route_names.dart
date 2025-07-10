class RouteNames {
  // Private constructor to prevent instantiation
  RouteNames._();

  // Main screens
  static const String splash = '/';
  static const String tutorial = '/tutorial';
  static const String stageSelect = '/stage-select';
  static const String stageItemSelection = '/stage-item-selection';
  static const String battle = '/battle';
  static const String stageClear = '/stage-clear';
  static const String inventory = '/inventory';
  static const String achievement = '/achievement';

  // Additional screens that might be added later
  static const String settings = '/settings';
  static const String statistics = '/statistics';
  static const String help = '/help';
  static const String about = '/about';

  // All route names for validation
  static const List<String> all = [
    splash,
    tutorial,
    stageSelect,
    stageItemSelection,
    battle,
    stageClear,
    inventory,
    achievement,
    settings,
    statistics,
    help,
    about,
  ];

  // Helper method to check if a route name is valid
  static bool isValidRoute(String routeName) {
    return all.contains(routeName);
  }

  // Get initial route based on app state
  static String getInitialRoute({
    required bool isFirstLaunch,
    required bool isTutorialCompleted,
  }) {
    if (isFirstLaunch || !isTutorialCompleted) {
      return tutorial;
    }
    return stageSelect;
  }
}