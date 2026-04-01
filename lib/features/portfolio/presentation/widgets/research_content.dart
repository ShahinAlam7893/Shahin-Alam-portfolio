// lib/features/portfolio/presentation/widgets/achievements_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/project_card.dart';
import '../providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ResearchContent extends StatelessWidget {
  const ResearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Research", style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 30.h),
          ...profile.research.map((r) =>ProjectCard(
                title: r["title"] ?? "",
                date: r["date"] ?? "",
                desc: r["desc"] ?? "", 
                tech: [],
               )
                ),
        ],
      ),
    );
  }
}