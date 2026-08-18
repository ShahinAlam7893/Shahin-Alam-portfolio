// lib/features/portfolio/presentation/widgets/skills_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'sections/section_header.dart';
import 'skill_group_card.dart';

class SkillsContent extends StatelessWidget {
  const SkillsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = context.watch<ProfileProvider>().skills.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Technical Skills", eyebrow: "Skills"),
        SizedBox(height: 32.h),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 20.0;
            final cols = constraints.maxWidth < 620 ? 1 : 2;
            final itemW = (constraints.maxWidth - spacing * (cols - 1)) / cols;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (final e in entries)
                  SizedBox(
                    width: itemW,
                    child: SkillGroupCard(title: e.key, skills: e.value),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
