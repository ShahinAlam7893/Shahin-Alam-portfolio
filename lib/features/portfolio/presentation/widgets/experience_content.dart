// lib/features/portfolio/presentation/widgets/experience_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'sections/section_header.dart';
import 'experience_card.dart';

class ExperienceContent extends StatelessWidget {
  const ExperienceContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Experience", eyebrow: "Career"),
        SizedBox(height: 32.h),
        ...profile.experiences.map((e) => ExperienceCard(
              role: e["role"] ?? "",
              company: e["company"] ?? "",
              date: e["date"] ?? "",
              desc: e["desc"] ?? "",
            )),
      ],
    );
  }
}
