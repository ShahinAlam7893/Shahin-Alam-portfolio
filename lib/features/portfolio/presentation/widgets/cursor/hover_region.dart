import 'package:flutter/material.dart';
import 'cursor_controller.dart';

/// Wraps [child] so that, when the custom cursor is enabled, hovering hides the
/// native cursor and grows the trailing ring. On touch / mobile it's a no-op
/// passthrough (native behaviour preserved).
class HoverRegion extends StatelessWidget {
  final Widget child;
  final double cursorScale;
  const HoverRegion({super.key, required this.child, this.cursorScale = 2.6});

  @override
  Widget build(BuildContext context) {
    final scope = CursorScope.maybeOf(context);
    if (scope == null || !scope.enabled) return child;
    final controller = scope.controller;
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onEnter: (_) => controller.enterHover(scale: cursorScale),
      onExit: (_) => controller.exitHover(),
      child: child,
    );
  }
}

/// A tappable element that nudges toward the pointer on hover ("magnetic"
/// effect), and grows the cursor ring. Falls back to a plain tap target when
/// the custom cursor is disabled.
class MagneticButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;

  /// Fraction of the pointer's offset-from-center the element follows.
  final double strength;

  /// Pixel clamp on the follow distance.
  final double maxOffset;

  final double cursorScale;

  const MagneticButton({
    super.key,
    required this.child,
    this.onPressed,
    this.strength = 0.3,
    this.maxOffset = 14,
    this.cursorScale = 3.0,
  });

  @override
  State<MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<MagneticButton> {
  Offset _offset = Offset.zero;

  void _update(PointerEvent e) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final center = Offset(box.size.width / 2, box.size.height / 2);
    final delta = e.localPosition - center;
    setState(() {
      _offset = Offset(
        (delta.dx * widget.strength).clamp(-widget.maxOffset, widget.maxOffset),
        (delta.dy * widget.strength).clamp(-widget.maxOffset, widget.maxOffset),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final scope = CursorScope.maybeOf(context);
    final enabled = scope?.enabled ?? false;
    final controller = scope?.controller;

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0),
      transformAlignment: Alignment.center,
      child: widget.child,
    );

    final tappable = GestureDetector(
      onTap: widget.onPressed,
      behavior: HitTestBehavior.opaque,
      child: content,
    );

    if (!enabled) return tappable;

    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onEnter: (_) => controller?.enterHover(scale: widget.cursorScale),
      onHover: _update,
      onExit: (_) {
        controller?.exitHover();
        setState(() => _offset = Offset.zero);
      },
      child: tappable,
    );
  }
}
