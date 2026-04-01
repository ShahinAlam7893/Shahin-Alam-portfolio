// lib/features/portfolio/presentation/widgets/education_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/experience_card.dart';

class EducationContent extends StatelessWidget {
  const EducationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Education",
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30.h),
          ...profile.education.map((e) => ExperienceCard(
                role: e["degree"] ?? "",      
                company: e["institute"] ?? "",
                date: e["date"] ?? "",        
                desc: e["grade"] ?? "",   
              )),
        ],
      ),
    );
  }
}