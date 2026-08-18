import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/core/theme/app_colors.dart';
import '../../providers/navigation_provider.dart';
import '../portfolio_sections.dart';

/// Slide-in drawer menu for the mobile layout.
class MobileNavMenu extends StatelessWidget {
  final List<PortfolioSection> sections;
  const MobileNavMenu({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    final accent = AppColors.accent(context);

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Row(
                children: [
                  const Text('SHAHIN',
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
                  Text('.',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 22, color: accent)),
                ],
              ),
            ),
            for (final s in sections)
              ListTile(
                leading: Icon(s.icon,
                    color: nav.active == s.id ? accent : null),
                title: Text(
                  s.label,
                  style: TextStyle(
                    fontWeight:
                        nav.active == s.id ? FontWeight.w700 : FontWeight.w500,
                    color: nav.active == s.id ? accent : null,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nav.requestScrollTo(s.id);
                },
              ),
          ],
        ),
      ),
    );
  }
}
