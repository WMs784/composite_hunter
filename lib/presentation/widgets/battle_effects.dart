import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/colors.dart';

// ─── Effect triggers ────────────────────────────────────────────────────────────
// Each trigger is bumped by the battle logic; the overlay and enemy card react.

/// A valid attack: [id] is unique per hit so repeated primes still re-trigger.
class BattleHit {
  final int id;
  final int prime;

  const BattleHit(this.id, this.prime);
}

final battleHitProvider = StateProvider<BattleHit?>((ref) => null);

/// Increments when a victory claim succeeds (confetti burst).
final battleCelebrationProvider = StateProvider<int>((ref) => 0);

/// Consecutive correct claims without a wrong claim or escape.
final battleComboProvider = StateProvider<int>((ref) => 0);

/// Honors the OS "reduce motion" setting for non-essential effects.
bool reduceMotionOf(BuildContext context) =>
    MediaQuery.disableAnimationsOf(context);

// ─── Overlay ────────────────────────────────────────────────────────────────────

/// Full-screen, non-interactive layer: floating "÷p" text, confetti, and a
/// pulsing red vignette while the timer is critical.
class BattleEffectsOverlay extends ConsumerStatefulWidget {
  final bool urgent;

  const BattleEffectsOverlay({super.key, required this.urgent});

  @override
  ConsumerState<BattleEffectsOverlay> createState() =>
      _BattleEffectsOverlayState();
}

class _BattleEffectsOverlayState extends ConsumerState<BattleEffectsOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _confettiController;
  late final AnimationController _vignetteController;

  int _floatPrime = 0;
  List<_ConfettiPiece> _pieces = const [];

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );
    _vignetteController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _confettiController.dispose();
    _vignetteController.dispose();
    super.dispose();
  }

  void _syncVignette(bool reduceMotion) {
    final shouldPulse = widget.urgent && !reduceMotion;
    if (shouldPulse && !_vignetteController.isAnimating) {
      _vignetteController.repeat(reverse: true);
    } else if (!shouldPulse && _vignetteController.isAnimating) {
      _vignetteController.stop();
      _vignetteController.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = reduceMotionOf(context);

    ref.listen<BattleHit?>(battleHitProvider, (previous, next) {
      if (next == null || reduceMotion) return;
      _floatPrime = next.prime;
      _floatController.forward(from: 0);
    });

    ref.listen<int>(battleCelebrationProvider, (previous, next) {
      if (reduceMotion) return;
      final rng = Random();
      _pieces = List.generate(48, (_) => _ConfettiPiece.random(rng));
      _confettiController.forward(from: 0);
    });

    _syncVignette(reduceMotion);

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _floatController,
          _confettiController,
          _vignetteController,
        ]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              if (widget.urgent)
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.timerCritical.withValues(
                          alpha: reduceMotion
                              ? 0.25
                              : 0.12 + 0.22 * _vignetteController.value,
                        ),
                      ],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              if (_floatController.isAnimating) _buildFloatingText(context),
              if (_confettiController.isAnimating)
                CustomPaint(
                  painter: _ConfettiPainter(
                    pieces: _pieces,
                    progress: _confettiController.value,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFloatingText(BuildContext context) {
    final t = Curves.easeOut.transform(_floatController.value);
    final opacity = (1 - _floatController.value).clamp(0.0, 1.0);
    return Align(
      alignment: Alignment(0, -0.2 - 0.35 * t),
      child: Opacity(
        opacity: opacity,
        child: Transform.scale(
          scale: 0.8 + 0.5 * Curves.elasticOut.transform(t.clamp(0.0, 1.0)),
          child: Text(
            '÷$_floatPrime',
            style: const TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFFEB3B),
              shadows: [
                Shadow(blurRadius: 6, color: Colors.black87),
                Shadow(offset: Offset(2, 3), color: Colors.black54),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Combo badge ────────────────────────────────────────────────────────────────

/// Shows "🔥 ×N" once the combo reaches 2; hidden otherwise.
class ComboBadge extends ConsumerWidget {
  const ComboBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combo = ref.watch(battleComboProvider);
    if (combo < 2) return const SizedBox.shrink();

    return TweenAnimationBuilder<double>(
      key: ValueKey(combo),
      tween: Tween(begin: reduceMotionOf(context) ? 1.0 : 1.5, end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFFFF6D00),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '🔥 ×$combo',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ─── Confetti ───────────────────────────────────────────────────────────────────

class _ConfettiPiece {
  final double x; // 0..1 start position
  final double drift; // horizontal drift in px
  final double fall; // fall speed multiplier
  final double spin;
  final double size;
  final Color color;

  const _ConfettiPiece({
    required this.x,
    required this.drift,
    required this.fall,
    required this.spin,
    required this.size,
    required this.color,
  });

  static const _palette = [
    Color(0xFFFFEB3B),
    Color(0xFF4CAF50),
    Color(0xFF29B6F6),
    Color(0xFFFF7043),
    Color(0xFFAB47BC),
  ];

  factory _ConfettiPiece.random(Random rng) => _ConfettiPiece(
    x: rng.nextDouble(),
    drift: (rng.nextDouble() - 0.5) * 120,
    fall: 0.7 + rng.nextDouble() * 0.6,
    spin: rng.nextDouble() * 2 * pi,
    size: 6 + rng.nextDouble() * 6,
    color: _palette[rng.nextInt(_palette.length)],
  );
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiPiece> pieces;
  final double progress;

  _ConfettiPainter({required this.pieces, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in pieces) {
      final y = -20 + (size.height * 0.9) * progress * p.fall;
      final x = p.x * size.width + p.drift * progress;
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.spin + progress * 8);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: p.size,
          height: p.size * 0.5,
        ),
        Paint()
          ..color = p.color.withValues(alpha: (1 - progress).clamp(0.0, 1.0)),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}
