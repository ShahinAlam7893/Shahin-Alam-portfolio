import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import 'portfolio_sections.dart';
import 'sections/section_container.dart';

/// The one vertical scroll shared by the website and mobile layouts. Owns the
/// [ScrollController] + per-section [GlobalKey]s, drives smooth scroll-to on
/// nav requests, and reports the active section for nav highlighting.
class SinglePageScroller extends StatefulWidget {
  final List<PortfolioSection> sections;
  final double topInset;
  final EdgeInsets? sectionPadding;
  final ValueChanged<bool>? onScrolledChanged;

  const SinglePageScroller({
    super.key,
    required this.sections,
    this.topInset = 0,
    this.sectionPadding,
    this.onScrolledChanged,
  });

  @override
  State<SinglePageScroller> createState() => SinglePageScrollerState();
}

class SinglePageScrollerState extends State<SinglePageScroller> {
  final ScrollController _controller = ScrollController();
  late Map<SectionId, GlobalKey> _keys;
  bool _tickScheduled = false;
  bool _showBackToTop = false;

  ScrollController get controller => _controller;

  @override
  void initState() {
    super.initState();
    _keys = {for (final s in widget.sections) s.id: GlobalKey()};
    _controller.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavigationProvider>().registerScrollHandler(scrollTo);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void scrollTo(SectionId id) {
    final ctx = _keys[id]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 620),
      curve: Curves.easeInOutCubic,
      alignment: 0.0,
    );
  }

  void scrollToTop() => _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );

  void _onScroll() {
    final shouldShow = _controller.hasClients && _controller.offset > 500;
    if (shouldShow != _showBackToTop) {
      _showBackToTop = shouldShow;
      widget.onScrolledChanged?.call(shouldShow);
    }
    if (_tickScheduled) return;
    _tickScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tickScheduled = false;
      _updateActive();
    });
  }

  void _updateActive() {
    if (!mounted) return;
    final threshold = widget.topInset + 120;
    SectionId active = widget.sections.first.id;
    for (final s in widget.sections) {
      final ctx = _keys[s.id]?.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;
      final dy = box.localToGlobal(Offset.zero).dy;
      if (dy <= threshold) {
        active = s.id;
      } else {
        break;
      }
    }
    context.read<NavigationProvider>().setActive(active);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final s in widget.sections)
            KeyedSubtree(
              key: _keys[s.id],
              child: SectionContainer(
                scrollController: _controller,
                padding: widget.sectionPadding,
                reveal: !s.isHero,
                child: s.body,
              ),
            ),
        ],
      ),
    );
  }
}
