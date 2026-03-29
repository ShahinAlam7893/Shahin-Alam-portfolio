import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/providers/profile_provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/providers/theme_provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/availability_badge.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/main_layout.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/stat_card.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final isDark = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;

    return MainLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Photo
              Container(
                width: 280.w,
                height: 280.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).primaryColor, width: 8),
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.3), blurRadius: 30)
                  ],
                ),
                child: ClipOval(
                  child: Image.asset('assets/images/profile.jpg', fit: BoxFit.cover),
                ),
              ).animate().scale(duration: 900.ms, curve: Curves.elasticOut),

              SizedBox(width: 60.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvailabilityBadge(isAvailable: true),

                    SizedBox(height: 30.h),

                    DefaultTextStyle(
                      style: TextStyle(fontSize: 68.sp, fontWeight: FontWeight.bold),
                      child: AnimatedTextKit(
                        animatedTexts: [TypewriterAnimatedText("Hi, I'm ${profile.name}")],
                        totalRepeatCount: 1,
                      ),
                    ),

                    Text(profile.title,
                        style: TextStyle(fontSize: 34.sp, color: Theme.of(context).primaryColor))
                        .animate().fadeIn(delay: 400.ms),

                    SizedBox(height: 30.h),

                    Text(profile.about, style: TextStyle(fontSize: 18.sp, height: 1.7))
                        .animate().fadeIn(delay: 600.ms),

                    SizedBox(height: 50.h),

                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => launchUrl(Uri.parse('assets/resume/SHAHIN_ALAM.pdf')),
                          icon: const Icon(Icons.download_rounded),
                          label: const Text("Download Resume"),
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h)),
                        ).animate(),

                        SizedBox(width: 24.w),

                        OutlinedButton.icon(
                          onPressed: () => context.go('/contact'),
                          icon: const Icon(Icons.mail_outline),
                          label: const Text("Let's Connect"),
                        ).animate(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 100.h),

          // Stats - Staggered
          Wrap(
            spacing: 24.w,
            runSpacing: 24.h,
            children: const [
              StatCard(icon: Icons.work, value: "5+", label: "Years Experience"),
              StatCard(icon: Icons.rocket_launch, value: "10+", label: "Flutter Projects"),
              StatCard(icon: Icons.analytics, value: "96%", label: "Model Accuracy"),
              StatCard(icon: Icons.school, value: "3+", label: "Research & Papers"),
            ].asMap().entries.map((e) => e.value.animate().fadeIn(delay: (200 * e.key).ms).slideY(begin: 40)).toList(),
          ),
        ],
      ),
    );
  }
}