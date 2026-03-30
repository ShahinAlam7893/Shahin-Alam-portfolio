import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/custom_animated_background.dart';
import 'custom_sidebar.dart';
import 'custom_nav_bar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final ScrollController? scrollController;
  final Function(double offset)? onNavTap;
  const MainLayout({super.key, required this.child, this.scrollController, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Full animated background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated subtle background elements
            const Positioned.fill(
              child: CustomAnimatedBackground(),
            ),

            // Main Content
            Row(
              children: [
                // Fixed Sidebar
                const CustomSidebar(),

                // Scrollable Main Area
                Expanded(
                  child: Column(
                    children: [
                      const CustomNavBar(),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 40.h),
                          child: child.animate().fadeIn(duration: 600.ms).slideY(begin: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}