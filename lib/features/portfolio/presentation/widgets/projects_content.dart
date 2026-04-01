// lib/features/portfolio/presentation/widgets/projects_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/project_card.dart';

class ProjectsContent extends StatelessWidget {
  const ProjectsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Featured Projects",
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30.h),
          ...profile.projects.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: ProjectCard(
                  title: p["title"],
                  desc: p["desc"],
                  date: p["date"],
                  tech: List<String>.from(p["tech"]),
                ),
              )),
        ],
      ),
    );
  }
}