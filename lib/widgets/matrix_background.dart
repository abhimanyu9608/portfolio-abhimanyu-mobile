import 'dart:math';
import 'package:flutter/material.dart';

class MatrixPainter extends CustomPainter {
  final List<_Drop> drops;
  final double animValue;

  MatrixPainter({required this.drops, required this.animValue});

  static const chars = '01アイウカΩΔΨ{}()[]<>=;:,.';

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random();
    for (final d in drops) {
      final isGreen = d.index % 5 == 0;
      final alpha = (0.1 + rng.nextDouble() * 0.3).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = isGreen
            ? Color.fromRGBO(0, 255, 136, alpha)
            : Color.fromRGBO(0, 212, 255, alpha);

      final char = chars[rng.nextInt(chars.length)];
      final tp = TextPainter(
        text: TextSpan(
          text: char,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            color: paint.color,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      tp.paint(canvas, Offset(d.x, d.y));

      // Move drop
      d.y += d.speed;
      if (d.y > size.height) {
        d.y = -20;
        d.x = rng.nextDouble() * size.width;
      }
    }
  }

  @override
  bool shouldRepaint(MatrixPainter old) => true;
}

class _Drop {
  double x, y, speed;
  int index;
  _Drop({required this.x, required this.y, required this.speed, required this.index});
}

class MatrixBackground extends StatefulWidget {
  const MatrixBackground({super.key});

  @override
  State<MatrixBackground> createState() => _MatrixBackgroundState();
}

class _MatrixBackgroundState extends State<MatrixBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<_Drop> _drops;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _drops = List.generate(80, (i) => _Drop(
      x: _rng.nextDouble() * 1920,
      y: _rng.nextDouble() * 1080,
      speed: 1.5 + _rng.nextDouble() * 2,
      index: i,
    ));
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _ctrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MatrixPainter(drops: _drops, animValue: _ctrl.value),
      size: Size.infinite,
    );
  }
}

// Grid overlay painter
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x0500D4FF)
      ..strokeWidth = 0.5;

    const spacing = 48.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(GridPainter old) => false;
}
