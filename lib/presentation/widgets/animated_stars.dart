import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AnimatedStars extends StatelessWidget {
  final int stars;
  final Animation<double> animation;

  const AnimatedStars({
    super.key,
    required this.stars,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final delay = index * 0.2;
        final starAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(delay, delay + 0.4, curve: Curves.elasticOut),
          ),
        );

        return AnimatedBuilder(
          animation: starAnimation,
          builder: (context, child) {
            final isActive = index < stars;
            // Clamp animation values to prevent layout errors
            final scale = isActive ? starAnimation.value.clamp(0.0, 2.0) : 0.8;
            final opacity = isActive
                ? starAnimation.value.clamp(0.0, 1.0)
                : 0.3;

            return Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    isActive ? Icons.star : Icons.star_border,
                    size: 48,
                    color: isActive ? Colors.amber : AppColors.outline,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
