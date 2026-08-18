// lib/features/portfolio/presentation/widgets/research_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'sections/section_header.dart';
import 'project_card.dart';

class ResearchContent extends StatelessWidget {
  const ResearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Research", eyebrow: "Publications"),
        SizedBox(height: 32.h),
        ...profile.research.map((r) => ProjectCard(
              title: r["title"] ?? "",
              date: r["date"] ?? "",
              desc: r["desc"] ?? "",
              tech: const [],
            )),
      ],
    );
  }
}
