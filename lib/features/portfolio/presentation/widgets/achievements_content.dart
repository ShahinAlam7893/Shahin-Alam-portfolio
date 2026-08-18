// lib/features/portfolio/presentation/widgets/achievements_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'sections/section_header.dart';
import 'info_card.dart';

class AchievementsContent extends StatelessWidget {
  const AchievementsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Achievements", eyebrow: "Awards"),
        SizedBox(height: 32.h),
        ...profile.achievements.map((a) => InfoCard(
              icon: Icons.emoji_events,
              title: a["title"] ?? "",
              subtitle: a["event"] ?? "",
            )),
      ],
    );
  }
}
