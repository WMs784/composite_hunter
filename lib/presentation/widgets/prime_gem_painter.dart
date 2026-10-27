import 'dart:math';
import 'package:flutter/material.dart';

/// Displays a prime number as a colored gem shape.
/// Used in battle screen prime buttons, item selection, and stage results.
class PrimeGem extends StatelessWidget {
  final int primeValue;
  final bool isAvailable;
  final double size;

  const PrimeGem({
    super.key,
    required this.primeValue,
    this.isAvailable = true,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: PrimeGemPainter(
          primeValue: primeValue,
          isAvailable: isAvailable,
        ),
      ),
    );
  }
}

/// CustomPainter that draws a prime number as a unique jewel shape.
/// Shape and color are determined by the prime value:
///   2→circle(blue), 3→triangle(green), 5→pentagon(orange),
///   7→heptagon(purple), 11→diamond(teal), 13→hexagon(red), larger→octagon(grey)
class PrimeGemPainter extends CustomPainter {
  final int primeValue;
  final bool isAvailable;

  PrimeGemPainter({required this.primeValue, required this.isAvailable});

  int get _sides {
    if (primeValue == 2) return 0;
    if (primeValue == 3) return 3;
    if (primeValue == 5) return 5;
    if (primeValue == 7) return 7;
    if (primeValue == 11) return 4;
    if (primeValue == 13) return 6;
    return 8;
  }

  Color get _gemColor {
    if (!isAvailable) return Colors.grey.shade500;
    if (primeValue == 2) return const Color(0xFF1565C0);
    if (primeValue == 3) return const Color(0xFF2E7D32);
    if (primeValue == 5) return const Color(0xFFE65100);
    if (primeValue == 7) return const Color(0xFF6A1B9A);
    if (primeValue == 11) return const Color(0xFF00695C);
    if (primeValue == 13) return const Color(0xFFC62828);
    return const Color(0xFF37474F);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = min(cx, cy) * 0.72;
    final sides = _sides;
    final color = _gemColor;

    final path = sides == 0
        ? (Path()..addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r)))
        : _buildPolygon(cx, cy, r, sides);

    // Shadow
    canvas.drawPath(
      path.shift(const Offset(2, 3)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.30)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    // Main fill
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
    // Facet effects
    canvas.save();
    canvas.clipPath(path);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - r * 0.12, cy - r * 0.22),
        width: r * 1.15,
        height: r * 0.65,
      ),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.20)
        ..style = PaintingStyle.fill,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - r * 0.28, cy - r * 0.32),
        width: r * 0.42,
        height: r * 0.25,
      ),
      Paint()
        ..color = Colors.white.withValues(alpha: isAvailable ? 0.60 : 0.30)
        ..style = PaintingStyle.fill,
    );
    canvas.restore();
    // Outline
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white.withValues(alpha: isAvailable ? 0.35 : 0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  Path _buildPolygon(double cx, double cy, double r, int sides) {
    final angleOffset = sides == 4 ? pi / 4 : -pi / 2;
    final path = Path();
    for (int i = 0; i < sides; i++) {
      final angle = 2 * pi * i / sides + angleOffset;
      final x = cx + r * cos(angle);
      final y = cy + r * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(PrimeGemPainter old) =>
      old.primeValue != primeValue || old.isAvailable != isAvailable;
}
