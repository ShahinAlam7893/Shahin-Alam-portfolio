// lib/features/portfolio/presentation/widgets/experience_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/experience_card.dart';

class ExperienceContent extends StatelessWidget {
  const ExperienceContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Experience",
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30.h),
          ...profile.experiences.map((e) => ExperienceCard(
                role: e["role"] ?? "",
                company: e["company"] ?? "",
                date: e["date"] ?? "",
                desc: e["desc"] ?? "",
              )),
        ],
      ),
    );
  }
}