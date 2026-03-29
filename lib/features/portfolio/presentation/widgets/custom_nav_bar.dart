import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/providers/theme_provider.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: Row(
        children: [
          Text("Portfolio", style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600)),
          const Spacer(),
          _navIcon(context, Icons.home, '/', "Home"),
          _navIcon(context, Icons.school, '/education', "Education"),
          _navIcon(context, Icons.work, '/experience', "Experience"),
          _navIcon(context, Icons.code, '/skills', "Skills"),
          _navIcon(context, Icons.rocket_launch, '/projects', "Projects"),
          _navIcon(context, Icons.emoji_events, '/achievements', "Achievements"),
          _navIcon(context, Icons.verified, '/certifications', "Certifications"),
          _navIcon(context, Icons.mail, '/contact', "Contact"),

          const SizedBox(width: 30),
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: themeProvider.toggleTheme,
          ).animate().rotate(duration: 400.ms),
        ],
      ),
    );
  }

  Widget _navIcon(BuildContext context, IconData icon, String route, String tooltip) {
    final isActive = GoRouterState.of(context).uri.toString() == route;
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon, color: isActive ? Theme.of(context).primaryColor : null),
        onPressed: () => context.go(route),
      ).animate(),
    );
  }
}