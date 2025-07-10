import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class MonsterWidget extends StatefulWidget {
  final int number;
  final bool isPrime;
  final double size;
  final bool isAnimated;

  const MonsterWidget({
    super.key,
    required this.number,
    required this.isPrime,
    this.size = 120.0,
    this.isAnimated = true,
  });

  @override
  State<MonsterWidget> createState() => _MonsterWidgetState();
}

class _MonsterWidgetState extends State<MonsterWidget>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _eyeController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _eyeAnimation;

  @override
  void initState() {
    super.initState();
    
    if (widget.isAnimated) {
      _bounceController = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      );
      
      _eyeController = AnimationController(
        duration: const Duration(milliseconds: 3000),
        vsync: this,
      );
      
      _bounceAnimation = Tween<double>(
        begin: 0.0,
        end: 0.1,
      ).animate(CurvedAnimation(
        parent: _bounceController,
        curve: Curves.elasticInOut,
      ));
      
      _eyeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _eyeController,
        curve: Curves.easeInOut,
      ));
      
      _bounceController.repeat(reverse: true);
      _eyeController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    if (widget.isAnimated) {
      _bounceController.dispose();
      _eyeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isAnimated) {
      return _buildMonster();
    }
    
    return AnimatedBuilder(
      animation: Listenable.merge([_bounceAnimation, _eyeAnimation]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceAnimation.value * 10),
          child: _buildMonster(),
        );
      },
    );
  }

  Widget _buildMonster() {
    final monsterType = _getMonsterType(widget.number);
    final monsterColor = _getMonsterColor(widget.number);
    
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.size * 0.3),
        gradient: RadialGradient(
          colors: [
            monsterColor.withOpacity(0.8),
            monsterColor,
            monsterColor.withOpacity(0.6),
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: monsterColor.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // モンスターボディ
          _buildMonsterBody(monsterType),
          
          // 目
          _buildEyes(monsterType),
          
          // 口
          _buildMouth(monsterType),
          
          // 数字表示
          _buildNumberDisplay(),
          
          // 特殊効果（素数の場合）
          if (widget.isPrime) _buildPrimeEffect(),
        ],
      ),
    );
  }

  Widget _buildMonsterBody(MonsterType type) {
    switch (type) {
      case MonsterType.small:
        return _buildBlobBody();
      case MonsterType.medium:
        return _buildSpikeyBody();
      case MonsterType.large:
        return _buildDragonBody();
      case MonsterType.boss:
        return _buildBossBody();
    }
  }

  Widget _buildBlobBody() {
    return Center(
      child: Container(
        width: widget.size * 0.8,
        height: widget.size * 0.8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildSpikeyBody() {
    return Center(
      child: CustomPaint(
        size: Size(widget.size * 0.8, widget.size * 0.8),
        painter: SpikeyBodyPainter(_getMonsterColor(widget.number)),
      ),
    );
  }

  Widget _buildDragonBody() {
    return Center(
      child: Container(
        width: widget.size * 0.9,
        height: widget.size * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size * 0.2),
          color: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildBossBody() {
    return Center(
      child: Container(
        width: widget.size * 0.95,
        height: widget.size * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size * 0.1),
          color: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildEyes(MonsterType type) {
    final eyeSize = widget.size * 0.12;
    final eyeOffset = widget.size * 0.15;
    
    return Positioned.fill(
      child: Stack(
        children: [
          // 左目
          Positioned(
            left: widget.size * 0.5 - eyeOffset - eyeSize / 2,
            top: widget.size * 0.35,
            child: _buildEye(eyeSize, type),
          ),
          // 右目
          Positioned(
            right: widget.size * 0.5 - eyeOffset - eyeSize / 2,
            top: widget.size * 0.35,
            child: _buildEye(eyeSize, type),
          ),
        ],
      ),
    );
  }

  Widget _buildEye(double size, MonsterType type) {
    final pupilSize = size * 0.6;
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.black26, width: 1),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: widget.isAnimated ? _eyeAnimation : 
                    const AlwaysStoppedAnimation(0.5),
          builder: (context, child) {
            final pupilOffset = _eyeAnimation.value * 3 - 1.5;
            return Transform.translate(
              offset: Offset(pupilOffset, 0),
              child: Container(
                width: pupilSize,
                height: pupilSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: type == MonsterType.boss ? Colors.red : Colors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMouth(MonsterType type) {
    final mouthWidth = widget.size * 0.3;
    final mouthHeight = widget.size * 0.15;
    
    return Positioned(
      left: widget.size * 0.5 - mouthWidth / 2,
      top: widget.size * 0.6,
      child: Container(
        width: mouthWidth,
        height: mouthHeight,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(mouthHeight / 2),
        ),
        child: type == MonsterType.boss ? _buildTeeth() : null,
      ),
    );
  }

  Widget _buildTeeth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index) {
        return Container(
          width: 3,
          height: 8,
          color: Colors.white,
        );
      }),
    );
  }

  Widget _buildNumberDisplay() {
    return Positioned(
      bottom: widget.size * 0.1,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.number.toString(),
            style: AppTextStyles.enemyValue.copyWith(
              color: Colors.white,
              fontSize: widget.size * 0.15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrimeEffect() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size * 0.3),
          border: Border.all(
            color: AppColors.victoryGreen,
            width: 3,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.star,
            color: AppColors.victoryGreen,
            size: 30,
          ),
        ),
      ),
    );
  }

  MonsterType _getMonsterType(int number) {
    if (number <= 20) return MonsterType.small;
    if (number <= 100) return MonsterType.medium;
    if (number <= 500) return MonsterType.large;
    return MonsterType.boss;
  }

  Color _getMonsterColor(int number) {
    if (widget.isPrime) return AppColors.victoryGreen;
    
    if (number <= 20) return Colors.blue.shade400;
    if (number <= 100) return Colors.orange.shade500;
    if (number <= 500) return Colors.red.shade500;
    return Colors.purple.shade700;
  }
}

enum MonsterType {
  small,
  medium,
  large,
  boss,
}

class SpikeyBodyPainter extends CustomPainter {
  final Color color;
  
  SpikeyBodyPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Create a spikey circle
    for (int i = 0; i < 8; i++) {
      final angle = (i * 2 * 3.14159) / 8;
      final spikeRadius = radius * (i % 2 == 0 ? 1.0 : 0.8);
      final x = center.dx + spikeRadius * math.cos(angle);
      final y = center.dy + spikeRadius * math.sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}