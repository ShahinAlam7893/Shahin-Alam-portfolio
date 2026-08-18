// lib/features/portfolio/presentation/widgets/certifications_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'sections/section_header.dart';
import 'info_card.dart';

class CertificationsContent extends StatelessWidget {
  const CertificationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Certifications", eyebrow: "Credentials"),
        SizedBox(height: 32.h),
        ...profile.certifications.map((c) => InfoCard(
              icon: Icons.verified,
              title: c["title"] ?? "",
              subtitle: c["issuer"] ?? "",
            )),
      ],
    );
  }
}
