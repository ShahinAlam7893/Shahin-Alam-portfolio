// lib/features/portfolio/presentation/widgets/achievements_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/profile_provider.dart';
import 'package:provider/provider.dart';

class AchievementsContent extends StatelessWidget {
  const AchievementsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Achievements",
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 30.h),
          ...profile.achievements.map((a) => ListTile(
                leading: const Icon(
                  Icons.emoji_events,
                ),
                title: Text(a["title"]!,
                    style: TextStyle(
                        fontSize: 24.sp, fontWeight: FontWeight.bold)),
                subtitle: Text(a["event"]!),
              )),
        ],
      ),
    );
  }
}
