import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shahin_portfolio/core/responsive/breakpoints.dart';

/// Wraps a single-page section: centers it in a readable max-width column,
/// applies responsive vertical rhythm, and fades/slides it in the first time it
/// scrolls into view (anindya-style reveal).
class SectionContainer extends StatefulWidget {
  final Widget child;
  final ScrollController? scrollController;
  final EdgeInsetsGeometry? padding;
  final double maxWidth;
  final bool reveal;

  const SectionContainer({
    super.key,
    required this.child,
    this.scrollController,
    this.padding,
    this.maxWidth = Breakpoints.contentMaxWidth,
    this.reveal = true,
  });

  @override
  State<SectionContainer> createState() => _SectionContainerState();
}

class _SectionContainerState extends State<SectionContainer> {
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    if (!widget.reveal) {
      _revealed = true;
      return;
    }
    widget.scrollController?.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_revealed || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final dy = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.sizeOf(context).height;
    if (dy < screenH * 0.88) {
      setState(() => _revealed = true);
      widget.scrollController?.removeListener(_check);
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_check);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobileWidth;
    final padding = widget.padding ??
        EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 48,
          vertical: isMobile ? 44 : 88,
        );

    Widget content = Padding(
      padding: padding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          child: widget.child,
        ),
      ),
    );

    return content
        .animate(target: _revealed ? 1 : 0)
        .fadeIn(duration: 500.ms, curve: Curves.easeOut)
        .slideY(begin: 0.1, end: 0, duration: 550.ms, curve: Curves.easeOutCubic);
  }
}
