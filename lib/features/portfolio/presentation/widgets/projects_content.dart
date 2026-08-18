// lib/features/portfolio/presentation/widgets/projects_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'sections/section_header.dart';
import 'project_card.dart';

class ProjectsContent extends StatelessWidget {
  const ProjectsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Featured Projects", eyebrow: "Work"),
        SizedBox(height: 32.h),
        ...profile.projects.map((p) => ProjectCard(
              title: p["title"],
              desc: p["desc"],
              date: p["date"],
              tech: List<String>.from(p["tech"]),
            )),
      ],
    );
  }
}
