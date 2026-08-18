import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'cursor_controller.dart';

/// Full-screen overlay that paints a solid dot (tracks the pointer exactly) and
/// a trailing ring (eased follow). Uses [BlendMode.difference] so it stays
/// visible over any background. Mouse-only — nothing paints until a real
/// pointer is seen. Must be wrapped in [IgnorePointer] by the caller.
class CustomCursorOverlay extends StatefulWidget {
  final CursorController controller;
  const CustomCursorOverlay({super.key, required this.controller});

  @override
  State<CustomCursorOverlay> createState() => _CustomCursorOverlayState();
}

class _CustomCursorOverlayState extends State<CustomCursorOverlay>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final ValueNotifier<Offset> _ringPos = ValueNotifier(Offset.zero);
  final ValueNotifier<double> _ringScaleShown = ValueNotifier(1.0);
  Offset _ring = Offset.zero;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _ring = widget.controller.pointer.value;
    _ticker = createTicker(_tick)..start();
  }

  void _tick(Duration _) {
    final target = widget.controller.pointer.value;
    _ring = Offset.lerp(_ring, target, 0.2)!;
    _scale = ui.lerpDouble(_scale, widget.controller.ringScale.value, 0.2)!;
    _ringPos.value = _ring;
    _ringScaleShown.value = _scale;
  }

  @override
  void dispose() {
    _ticker.dispose();
    _ringPos.dispose();
    _ringScaleShown.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size.infinite,
          painter: _CursorPainter(
            pointer: widget.controller.pointer,
            ringPos: _ringPos,
            ringScale: _ringScaleShown,
            active: widget.controller.active,
          ),
        ),
      ),
    );
  }
}

class _CursorPainter extends CustomPainter {
  final ValueListenable<Offset> pointer;
  final ValueListenable<Offset> ringPos;
  final ValueListenable<double> ringScale;
  final ValueListenable<bool> active;

  _CursorPainter({
    required this.pointer,
    required this.ringPos,
    required this.ringScale,
    required this.active,
  }) : super(
          repaint: Listenable.merge([pointer, ringPos, ringScale, active]),
        );

  @override
  void paint(Canvas canvas, Size size) {
    if (!active.value) return;
    final dot = pointer.value;
    final ring = ringPos.value;
    final ringR = 15.0 * ringScale.value;

    // Tight layer around both marks keeps the difference blend cheap.
    final bounds = Rect.fromCircle(center: ring, radius: ringR + 6)
        .expandToInclude(Rect.fromCircle(center: dot, radius: 8));
    canvas.saveLayer(bounds, Paint()..blendMode = BlendMode.difference);

    const white = Color(0xFFFFFFFF);
    canvas.drawCircle(
      ring,
      ringR,
      Paint()
        ..color = white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..isAntiAlias = true,
    );
    canvas.drawCircle(
      dot,
      3.5,
      Paint()
        ..color = white
        ..isAntiAlias = true,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CursorPainter oldDelegate) => false;
}
