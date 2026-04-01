// lib/features/portfolio/presentation/widgets/skills_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/skill_group_card.dart';

class SkillsContent extends StatelessWidget {
  const SkillsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Technical Skills",
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30.h),
          Center(
            child: Wrap(
              spacing: 20.w,
              runSpacing: 20.h,
              children: profile.skills.entries
                  .map((e) => SkillGroupCard(title: e.key, skills: e.value))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}