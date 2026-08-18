import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/core/theme/app_colors.dart';
import '../../providers/navigation_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/view_mode_provider.dart';
import '../portfolio_sections.dart';
import '../cursor/hover_region.dart';
import '../cursor/scramble_text.dart';

/// Sticky top navigation for the website layout: brand on the left, scramble
/// nav links + theme/view toggles on the right. Below ~1000px the links
/// collapse into a popup menu so they never overflow.
class TopNavBar extends StatelessWidget {
  final List<PortfolioSection> sections;
  const TopNavBar({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    final theme = context.watch<ThemeProvider>();
    final viewMode = context.read<ViewModeProvider>();
    final isDark = theme.themeMode == ThemeMode.dark;
    final navItems = sections.where((s) => s.showInNav).toList();

    return ClipRect(
      child: Container(
        height: 68,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .scaffoldBackgroundColor
              .withOpacity(isDark ? 0.72 : 0.82),
          border: Border(
            bottom: BorderSide(color: AppColors.border(context).withOpacity(0.4)),
          ),
        ),
        child: Row(
          children: [
            HoverRegion(
              child: GestureDetector(
                onTap: () => nav.requestScrollTo(SectionId.home),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('SHAHIN',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            letterSpacing: 1)),
                    Text('.',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: AppColors.accent(context))),
                  ],
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Rough space needed for inline links (~92px each).
                  final compact = constraints.maxWidth < navItems.length * 92;
                  if (compact) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: _NavMenuButton(items: navItems, nav: nav),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (final s in navItems)
                        _NavLink(
                          section: s,
                          active: nav.active == s.id,
                          onTap: () => nav.requestScrollTo(s.id),
                        ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            HoverRegion(
              cursorScale: 2,
              child: IconButton(
                tooltip: 'Switch to mobile view',
                onPressed: viewMode.toggle,
                icon: const Icon(Icons.phone_iphone_outlined, size: 20),
              ),
            ),
            HoverRegion(
              cursorScale: 2,
              child: IconButton(
                tooltip: isDark ? 'Light mode' : 'Dark mode',
                onPressed: theme.toggleTheme,
                icon: Icon(
                    isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                    size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavMenuButton extends StatelessWidget {
  final List<PortfolioSection> items;
  final NavigationProvider nav;
  const _NavMenuButton({required this.items, required this.nav});

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      cursorScale: 2,
      child: PopupMenuButton<SectionId>(
        tooltip: 'Menu',
        icon: const Icon(Icons.menu),
        onSelected: nav.requestScrollTo,
        itemBuilder: (context) => [
          for (final s in items)
            PopupMenuItem(
              value: s.id,
              child: Row(
                children: [
                  Icon(s.icon, size: 18),
                  const SizedBox(width: 12),
                  Text(s.label),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final PortfolioSection section;
  final bool active;
  final VoidCallback onTap;
  const _NavLink(
      {required this.section, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accent(context);
    final baseColor = Theme.of(context).textTheme.bodyLarge?.color;
    return HoverRegion(
      cursorScale: 2.2,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScrambleText(
                section.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  color: active ? accent : baseColor,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2,
                width: active ? 18 : 0,
                color: accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
