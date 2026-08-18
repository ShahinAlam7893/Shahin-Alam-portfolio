import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/core/theme/app_colors.dart';
import '../providers/theme_provider.dart';
import '../providers/view_mode_provider.dart';
import '../widgets/portfolio_sections.dart';
import '../widgets/single_page_scroller.dart';
import '../widgets/nav/mobile_nav_menu.dart';
import '../widgets/nav/back_to_top_button.dart';

/// Single-column, single-page mobile layout. Pure content (no ScreenUtilInit) so
/// it can be reused full-screen on a real phone AND inside the iPhone frame.
///
/// [showViewToggle] adds a "switch to website view" action (used inside the
/// desktop frame preview and on real phones).
class MobileLayout extends StatefulWidget {
  final bool showViewToggle;
  const MobileLayout({super.key, this.showViewToggle = true});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  final GlobalKey<SinglePageScrollerState> _scrollerKey = GlobalKey();
  bool _showBackToTop = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final viewMode = context.read<ViewModeProvider>();
    final isDark = theme.themeMode == ThemeMode.dark;

    final sections = buildSections(
      onViewToggle: widget.showViewToggle ? viewMode.toggle : null,
      isMobileView: true,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: MobileNavMenu(sections: sections),
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('SHAHIN',
                style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
            Text('.',
                style: TextStyle(
                    fontWeight: FontWeight.w900, color: AppColors.accent(context))),
          ],
        ),
        actions: [
          if (widget.showViewToggle)
            IconButton(
              tooltip: 'Switch to website view',
              onPressed: viewMode.toggle,
              icon: const Icon(Icons.desktop_windows_outlined, size: 20),
            ),
          IconButton(
            tooltip: isDark ? 'Light mode' : 'Dark mode',
            onPressed: theme.toggleTheme,
            icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                size: 20),
          ),
        ],
      ),
      body: Stack(
        children: [
          SinglePageScroller(
            key: _scrollerKey,
            sections: sections,
            topInset: 0,
            onScrolledChanged: (v) => setState(() => _showBackToTop = v),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: BackToTopButton(
              visible: _showBackToTop,
              onTap: () => _scrollerKey.currentState?.scrollToTop(),
            ),
          ),
        ],
      ),
    );
  }
}
