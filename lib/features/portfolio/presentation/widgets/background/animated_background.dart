import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../cursor/cursor_controller.dart';

/// anindya.pro-style layered backdrop: deep gradient + drifting soft blobs +
/// faint dot grid + subtle grain + a pointer-reactive glow.
///
/// Everything is pre-softened (RadialGradients) — deliberately NO
/// BackdropFilter/blur, which janks CanvasKit on web. Pass [lite] on mobile to
/// drop the pointer glow, grain and third blob and freeze motion.
class AnimatedBackground extends StatelessWidget {
  final CursorController? cursor;
  final bool lite;
  const AnimatedBackground({super.key, this.cursor, this.lite = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final accent = isDark ? const Color(0xFF3FA9F5) : const Color(0xFF2563EB);
    final violet = isDark ? const Color(0xFF7C5CFF) : const Color(0xFF8B5CF6);
    final base1 = isDark ? const Color(0xFF0B2A47) : const Color(0xFFF6F9FD);
    final base2 = isDark ? const Color(0xFF050E18) : const Color(0xFFE6EEF8);

    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final animate = !lite && !reduceMotion;

    return RepaintBoundary(
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [base1, base2],
                ),
              ),
            ),
          ),
          _blob(accent.withOpacity(isDark ? 0.22 : 0.14), 620,
              const Alignment(-0.85, -0.95), const Offset(120, 90), animate, 26),
          _blob(violet.withOpacity(isDark ? 0.16 : 0.10), 520,
              const Alignment(0.95, 0.85), const Offset(-110, -70), animate, 32),
          if (!lite)
            _blob(accent.withOpacity(isDark ? 0.10 : 0.07), 420,
                const Alignment(0.25, -0.6), const Offset(-90, 120), animate, 38),
          Positioned.fill(
            child: CustomPaint(
              painter: _DotGridPainter(
                color: (isDark ? Colors.white : Colors.black)
                    .withOpacity(isDark ? 0.05 : 0.045),
              ),
            ),
          ),
          if (!lite)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _GrainPainter(opacity: isDark ? 0.035 : 0.022),
                ),
              ),
            ),
          if (cursor != null && !lite)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  size: Size.infinite,
                  painter: _GlowPainter(
                    cursor: cursor!,
                    color: accent.withOpacity(isDark ? 0.18 : 0.12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _blob(Color color, double size, Alignment align, Offset move,
      bool animate, int seconds) {
    Widget circle = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withOpacity(0)]),
      ),
    );
    if (animate) {
      circle = circle
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .move(
            begin: Offset.zero,
            end: move,
            duration: seconds.seconds,
            curve: Curves.easeInOutSine,
          );
    }
    return Positioned.fill(child: Align(alignment: align, child: circle));
  }
}

class _DotGridPainter extends CustomPainter {
  final Color color;
  _DotGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const gap = 34.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;
    final points = <Offset>[];
    for (double y = 0; y < size.height; y += gap) {
      for (double x = 0; x < size.width; x += gap) {
        points.add(Offset(x, y));
      }
    }
    canvas.drawPoints(ui.PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter old) => old.color != color;
}

class _GrainPainter extends CustomPainter {
  final double opacity;
  _GrainPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final rand = Random(42); // fixed seed → stable, no per-frame flicker
    final count = ((size.width * size.height) / 900).clamp(0, 9000).toInt();
    final points = <Offset>[];
    for (var i = 0; i < count; i++) {
      points.add(Offset(rand.nextDouble() * size.width,
          rand.nextDouble() * size.height));
    }
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..strokeWidth = 1.0;
    canvas.drawPoints(ui.PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(covariant _GrainPainter old) => old.opacity != opacity;
}

class _GlowPainter extends CustomPainter {
  final CursorController cursor;
  final Color color;
  _GlowPainter({required this.cursor, required this.color})
      : super(repaint: Listenable.merge([cursor.pointer, cursor.active]));

  @override
  void paint(Canvas canvas, Size size) {
    if (!cursor.active.value) return;
    final pos = cursor.pointer.value;
    const r = 280.0;
    final rect = Rect.fromCircle(center: pos, radius: r);
    final paint = Paint()
      ..shader = RadialGradient(colors: [color, color.withOpacity(0)])
          .createShader(rect);
    canvas.drawCircle(pos, r, paint);
  }

  @override
  bool shouldRepaint(covariant _GlowPainter old) => false;
}
