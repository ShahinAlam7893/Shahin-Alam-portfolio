import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_sidebar.dart';
import 'custom_nav_bar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const CustomSidebar()
              .animate()
              .slideX(begin: -0.4, duration: 700.ms, curve: Curves.easeOutCubic),

          Expanded(
            child: Column(
              children: [
                const CustomNavBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 40.h),
                    child: child
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 30, curve: Curves.easeOut),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}