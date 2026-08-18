import 'package:flutter/widgets.dart';

/// Holds the live pointer state that drives the custom cursor and the
/// pointer-reactive background glow. Uses [ValueNotifier]s so only the painters
/// that listen repaint — never the whole widget tree — on mouse move.
class CursorController {
  /// Exact pointer position (the solid dot tracks this 1:1).
  final ValueNotifier<Offset> pointer = ValueNotifier(Offset.zero);

  /// Target scale of the trailing ring (grows on hover over interactives).
  final ValueNotifier<double> ringScale = ValueNotifier(1.0);

  /// Whether the pointer is currently over an interactive element.
  final ValueNotifier<bool> hovering = ValueNotifier(false);

  /// True once a real mouse has been seen and is on-screen.
  final ValueNotifier<bool> active = ValueNotifier(false);

  void setPointer(Offset p) {
    pointer.value = p;
    if (!active.value) active.value = true;
  }

  void setActive(bool v) => active.value = v;

  void enterHover({double scale = 2.6}) {
    hovering.value = true;
    ringScale.value = scale;
  }

  void exitHover() {
    hovering.value = false;
    ringScale.value = 1.0;
  }

  void dispose() {
    pointer.dispose();
    ringScale.dispose();
    hovering.dispose();
    active.dispose();
  }
}

/// Exposes the [CursorController] (and whether the custom cursor is enabled at
/// all) to descendants. Interactive wrappers read this to decide whether to
/// hide the native cursor and report hover state.
class CursorScope extends InheritedWidget {
  final CursorController controller;
  final bool enabled;

  const CursorScope({
    super.key,
    required this.controller,
    required this.enabled,
    required super.child,
  });

  static CursorScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CursorScope>();

  @override
  bool updateShouldNotify(CursorScope oldWidget) =>
      enabled != oldWidget.enabled || controller != oldWidget.controller;
}
