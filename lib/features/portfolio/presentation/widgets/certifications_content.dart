// lib/features/portfolio/presentation/widgets/certifications_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CertificationsContent extends StatelessWidget {
  const CertificationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Certifications",
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 30.h),
          _certCard("Full-Stack Web Development", "OSTAD • 2024"),
          _certCard("PHP and Laravel Framework", "BASIS • 2023"),
          _certCard("Skills for Career Progression", "PCIU • 2022"),
          _certCard("Digital Marketing", "SR Dream IT • 2022"),
        ],
      ),
    );
  }

  Widget _certCard(String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ListTile(
        leading: const Icon(Icons.verified, size: 40),
        title: Text(title, style: TextStyle(fontSize: 30.sp)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
