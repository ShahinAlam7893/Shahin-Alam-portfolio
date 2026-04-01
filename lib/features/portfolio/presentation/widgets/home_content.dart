// lib/features/portfolio/presentation/widgets/home_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../providers/navigation_provider.dart';
import '../widgets/availability_badge.dart';
import '../widgets/stat_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final nav = Provider.of<NavigationProvider>(context, listen: false);

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 38.r,
                backgroundImage: const AssetImage('assets/images/profile.jpg'),
              )
                  .animate()
                  .fadeIn()
                  .scale(begin: const Offset(0.85, 0.85), duration: 500.ms),
              SizedBox(width: 16.w),
              const AvailabilityBadge(isAvailable: true),
            ],
          ),
          SizedBox(height: 30.h),
          Text(
            "Hi, I'm ${profile.name}",
            style: TextStyle(fontSize: 46.sp, fontWeight: FontWeight.bold),
          ).animate().fadeIn(),
          Text(
            profile.title,
            style: TextStyle(fontSize: 30.sp, color: Colors.lightBlueAccent),
          ),
          SizedBox(height: 20.h),
          Text(
            profile.about,
            style: TextStyle(fontSize: 20.sp, height: 1.65),
          ),
          SizedBox(height: 50.h),
          Center(
            child: Wrap(
              spacing: 16.w,
              runSpacing: 16.h,
              children: [
                StatCard(
                  icon: Icons.work,
                  value: "5+",
                  label: "Experience",
                  onTap: () => nav.navigateTo(3),
                ),
                StatCard(
                  icon: Icons.rocket_launch,
                  value: "6+",
                  label: "Projects",
                  onTap: () => nav.navigateTo(2),
                ),
                StatCard(
                  icon: Icons.analytics,
                  value: "3+",
                  label: "Research",
                  onTap: () => nav.navigateTo(5),
                ),
                StatCard(
                  icon: Icons.emoji_events,
                  value: "3",
                  label: "Achievements",
                  onTap: () => nav.navigateTo(6),
                ),
                StatCard(
                  icon: Icons.verified,
                  value: "4",
                  label: "Certificates",
                  onTap: () => nav.navigateTo(7),
                ),
                StatCard(
                  icon: Icons.school_rounded,
                  value: "16+ Years",
                  label: "Education",
                  onTap: () => nav.navigateTo(8),
                ),
                StatCard(
                  icon: Icons.volunteer_activism,
                  value: "4+",
                  label: "Activities",
                  onTap: () => nav.navigateTo(9),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
