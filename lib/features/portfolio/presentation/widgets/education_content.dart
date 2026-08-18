// lib/features/portfolio/presentation/widgets/education_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'sections/section_header.dart';
import 'experience_card.dart';

class EducationContent extends StatelessWidget {
  const EducationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Education", eyebrow: "Academic"),
        SizedBox(height: 32.h),
        ...profile.education.map((e) => ExperienceCard(
              role: e["degree"] ?? "",
              company: e["institute"] ?? "",
              date: e["date"] ?? "",
              desc: e["grade"] ?? "",
            )),
      ],
    );
  }
}
