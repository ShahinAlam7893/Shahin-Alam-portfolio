import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/core/responsive/breakpoints.dart';
import '../providers/view_mode_provider.dart';
import '../widgets/background/animated_background.dart';
import '../widgets/cursor/cursor_controller.dart';
import '../widgets/cursor/custom_cursor_overlay.dart';
import 'website_layout.dart';
import 'mobile_layout.dart';
import 'mobile_frame_preview.dart';

/// Root of the portfolio. Owns the animated background + custom-cursor overlay,
/// runs one-time device auto-detect, and picks the layout for the current view
/// mode + viewport.
class PortfolioShell extends StatefulWidget {
  const PortfolioShell({super.key});

  @override
  State<PortfolioShell> createState() => _PortfolioShellState();
}

class _PortfolioShellState extends State<PortfolioShell> {
  final CursorController _cursor = CursorController();
  bool _hasMouse = false;

  @override
  void dispose() {
    _cursor.dispose();
    super.dispose();
  }

  void _onPointerHover(PointerHoverEvent e) {
    if (e.kind == PointerDeviceKind.touch) return;
    if (!_hasMouse) setState(() => _hasMouse = true);
    _cursor.setPointer(e.position);
  }

  @override
  Widget build(BuildContext context) {
    final viewMode = context.watch<ViewModeProvider>();
    final width = context.screenWidth;
    final isNarrow = width < Breakpoints.mobile;

    // One-time auto-detect (guarded inside the provider by hasStoredChoice).
    if (!viewMode.hasStoredChoice) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) viewMode.applyAutoDetect(width);
      });
    }

    // Custom cursor: desktop mouse only, and never when showing a mobile layout.
    final mobileLayoutActive = viewMode.isMobile;
    final cursorEnabled = _hasMouse && !isNarrow && !mobileLayoutActive;

    // Choose the layout.
    late final Widget layout;
    if (viewMode.isWebsite) {
      layout = const WebsiteLayout();
    } else if (isNarrow) {
      // Real phone (or very narrow window) → full-screen mobile. Scope
      // flutter_screenutil to the phone design canvas so .sp/.w/.h size right.
      layout = ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (_, __) => const MobileLayout(),
      );
    } else {
      // Desktop asked for mobile view → show it inside the iPhone frame.
      layout = const MobileFramePreview();
    }

    Widget content = Stack(
      children: [
        Positioned.fill(
          child: AnimatedBackground(
            cursor: cursorEnabled ? _cursor : null,
            lite: mobileLayoutActive || isNarrow,
          ),
        ),
        Positioned.fill(child: layout),
      ],
    );

    // Cursor tracking + overlay layer (mouse only).
    content = MouseRegion(
      cursor: cursorEnabled ? SystemMouseCursors.none : MouseCursor.defer,
      onHover: _onPointerHover,
      onExit: (_) => _cursor.setActive(false),
      opaque: false,
      child: Stack(
        children: [
          Positioned.fill(child: content),
          if (cursorEnabled)
            Positioned.fill(child: CustomCursorOverlay(controller: _cursor)),
        ],
      ),
    );

    return CursorScope(
      controller: _cursor,
      enabled: cursorEnabled,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: content,
      ),
    );
  }
}
