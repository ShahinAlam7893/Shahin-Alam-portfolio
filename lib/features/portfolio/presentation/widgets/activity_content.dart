// lib/features/portfolio/presentation/widgets/activity_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'sections/section_header.dart';
import 'info_card.dart';

class ActivityContent extends StatelessWidget {
  const ActivityContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
            title: "Leadership & Activities", eyebrow: "Community"),
        SizedBox(height: 32.h),
        ...profile.activities.map((a) => InfoCard(
              icon: Icons.volunteer_activism,
              title: a["title"] ?? "",
              subtitle: a["issuer"] ?? "",
            )),
      ],
    );
  }
}
