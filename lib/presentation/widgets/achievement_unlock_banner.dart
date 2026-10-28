import 'package:flutter/material.dart';
import '../l10n/achievement_l10n.dart';
import '../../domain/entities/achievement.dart';
import '../../flutter_gen/gen_l10n/app_localizations.dart';

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

/// Shows achievement unlock notifications sequentially.
///
/// Based on game-ui-design skill:
///   - Appear 200-250ms, display 3-5s, dismiss 300ms, queue gap 500ms
///   - Max 2-3 visible at once (sequential queue)
///
/// Based on game-designer skill:
///   - Big moments need big animation (Exaggeration)
///   - Secondary action: staggered icon + text entrance
///   - Easing: spring/elastic for satisfying feel
void showAchievementUnlockNotifications(
  BuildContext context,
  List<Achievement> achievements,
) {
  for (int i = 0; i < achievements.length; i++) {
    // 500ms gap between notifications (game-ui-design: queue gap)
    Future.delayed(Duration(milliseconds: i * 500), () {
      if (context.mounted) {
        _insertBanner(context, achievements[i]);
      }
    });
  }
}

void _insertBanner(BuildContext context, Achievement achievement) {
  OverlayEntry? entry;
  entry = OverlayEntry(
    builder: (_) => _AchievementBannerOverlay(
      achievement: achievement,
      onDismiss: () {
        try {
          entry?.remove();
        } catch (_) {}
        entry = null;
      },
    ),
  );
  Overlay.of(context).insert(entry!);
}

// ---------------------------------------------------------------------------
// Overlay widget
// ---------------------------------------------------------------------------

class _AchievementBannerOverlay extends StatefulWidget {
  final Achievement achievement;
  final VoidCallback onDismiss;

  const _AchievementBannerOverlay({
    required this.achievement,
    required this.onDismiss,
  });

  @override
  State<_AchievementBannerOverlay> createState() =>
      _AchievementBannerOverlayState();
}

class _AchievementBannerOverlayState extends State<_AchievementBannerOverlay>
    with TickerProviderStateMixin {
  // Entrance controller (250ms — within ≤300ms sharp edge rule)
  late final AnimationController _entranceCtrl;

  // Exit fade controller (300ms — fades banner out after display period)
  late final AnimationController _exitCtrl;

  // Epic/Legendary glow pulse controller
  late final AnimationController _glowCtrl;

  // --- Entrance animations (game-designer: Staging — staggered reveal) ---
  late final Animation<Offset> _slideIn;
  late final Animation<double> _bannerScale; // Squash & stretch on entrance
  late final Animation<double> _iconScale; // Secondary action: elastic bounce
  late final Animation<double> _textFade; // Follow through: text fades last

  // --- Glow pulse (only for epic / legendary) ---
  late final Animation<double> _glowPulse;

  // --- Exit fade (separate from entrance so banner stays fully visible during display) ---
  late final Animation<double> _exitFade;

  static const _displayDuration = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();

    // game-ui-design sharp edge: "Keep UI animations under 300ms"
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    // Exit fade: 300ms opacity 1→0 after display period
    _exitCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Banner slides down + scales in (game-designer: Slow-In/Slow-Out, arc)
    // Interval 0.0 → 0.85 with easeOutBack → slight overshoot = stretch feel
    final entranceCurve = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.85, curve: Curves.easeOutBack),
    );

    _slideIn = Tween<Offset>(
      begin: const Offset(0, -1.4),
      end: Offset.zero,
    ).animate(entranceCurve);

    _bannerScale = Tween<double>(begin: 0.88, end: 1.0).animate(entranceCurve);

    // Trophy icon bounces in later (game-designer: Secondary Action)
    // Interval 0.28 → 1.0 with elasticOut → Squash & Stretch
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.28, 1.0, curve: Curves.elasticOut),
      ),
    );

    // Text fades in last (game-designer: Staging — critical info first)
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.45, 1.0, curve: Curves.easeIn),
      ),
    );

    // Glow pulse for epic/legendary (game-designer: Exaggeration)
    _glowPulse = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    // Exit fade driven by dedicated controller (1.0 → 0.0 as _exitCtrl plays forward)
    _exitFade = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _exitCtrl, curve: Curves.easeIn));

    _entranceCtrl.forward();

    // Start glow pulse for high-rarity achievements
    if (_isHighRarity) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _glowCtrl.repeat(reverse: true);
      });
    }

    // Auto-dismiss: display 3s, then reverse 300ms
    Future.delayed(_displayDuration, _startDismiss);
  }

  bool get _isHighRarity =>
      widget.achievement.rarity == AchievementRarity.epic ||
      widget.achievement.rarity == AchievementRarity.legendary;

  void _startDismiss() {
    if (!mounted) return;
    _glowCtrl.stop();
    // Play exit fade forward (opacity 1→0), then remove overlay
    _exitCtrl.forward().then((_) => widget.onDismiss());
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _exitCtrl.dispose();
    _glowCtrl.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Rarity helpers
  // -------------------------------------------------------------------------

  Color get _rarityColor {
    switch (widget.achievement.rarity) {
      case AchievementRarity.common:
        return const Color(0xFF9E9E9E);
      case AchievementRarity.uncommon:
        return const Color(0xFF4CAF50);
      case AchievementRarity.rare:
        return const Color(0xFF2196F3);
      case AchievementRarity.epic:
        return const Color(0xFF9C27B0);
      case AchievementRarity.legendary:
        return const Color(0xFFFF9800);
    }
  }

  String get _rarityLabel {
    switch (widget.achievement.rarity) {
      case AchievementRarity.common:
        return 'COMMON';
      case AchievementRarity.uncommon:
        return 'UNCOMMON';
      case AchievementRarity.rare:
        return 'RARE';
      case AchievementRarity.epic:
        return 'EPIC';
      case AchievementRarity.legendary:
        return 'LEGENDARY ✦';
    }
  }

  // -------------------------------------------------------------------------
  // Build
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      // game-ui-design: safe zone — keep out of top system area
      top: topPadding + 8,
      left: 16,
      right: 16,
      child: AnimatedBuilder(
        animation: Listenable.merge([_entranceCtrl, _exitCtrl, _glowCtrl]),
        builder: (context, _) {
          return SlideTransition(
            position: _slideIn,
            child: Transform.scale(
              scale: _bannerScale.value,
              child: Opacity(
                opacity: _exitFade.value.clamp(0.0, 1.0),
                child: _buildCard(l10n),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(AppLocalizations l10n) {
    final glowBlur = _isHighRarity ? (8.0 + _glowPulse.value * 12.0) : 10.0;

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          // Dark game-UI background for readability under motion
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(12),
          border: Border(left: BorderSide(color: _rarityColor, width: 4)),
          boxShadow: [
            BoxShadow(
              // game-ui-design: text contrast via background, glow communicates rarity
              color: _rarityColor.withValues(
                alpha: _isHighRarity ? 0.25 + _glowPulse.value * 0.2 : 0.28,
              ),
              blurRadius: glowBlur,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          children: [
            _buildIcon(),
            const SizedBox(width: 12),
            Expanded(child: _buildTextContent(l10n)),
          ],
        ),
      ),
    );
  }

  /// Trophy icon with elastic bounce (game-designer: Secondary Action)
  Widget _buildIcon() {
    return Transform.scale(
      scale: _iconScale.value.clamp(0.0, 1.25), // clamp the elastic overshoot
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: _rarityColor.withValues(alpha: 0.18),
          shape: BoxShape.circle,
          border: Border.all(
            color: _rarityColor.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Icon(Icons.emoji_events, color: _rarityColor, size: 26),
      ),
    );
  }

  /// Text content fades in after icon (game-designer: Staging)
  Widget _buildTextContent(AppLocalizations l10n) {
    return Opacity(
      opacity: _textFade.value.clamp(0.0, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header row: "Achievement Unlocked!" + rarity badge
          Row(
            children: [
              Text(
                l10n.achievementUnlocked,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(width: 6),
              _buildRarityBadge(),
            ],
          ),
          const SizedBox(height: 3),
          // Achievement title — game-ui-design: text shadow for readability
          Text(
            l10n.achievementTitle(widget.achievement),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              // game-ui-design sharp edge: "HUD text must have shadow/outline"
              shadows: const [
                Shadow(
                  color: Colors.black54,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          // Reward text in rarity color
          Text(
            l10n.achievementReward(widget.achievement.rewardDisplayText),
            style: TextStyle(
              color: _rarityColor.withValues(alpha: 0.9),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRarityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _rarityColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: _rarityColor.withValues(alpha: 0.5),
          width: 0.8,
        ),
      ),
      child: Text(
        _rarityLabel,
        style: TextStyle(
          color: _rarityColor,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
