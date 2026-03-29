import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/main_layout.dart';

class CertificationsPage extends StatelessWidget {
  const CertificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Certifications", style: TextStyle(fontSize: 52.sp, fontWeight: FontWeight.bold))
              .animate().fadeIn().slideY(),

          SizedBox(height: 50.h),

          Wrap(
            spacing: 24.w,
            runSpacing: 24.h,
            children: [
              _certCard("Full-Stack Web Development", "OSTAD • 2024"),
              _certCard("PHP and Laravel Framework", "BASIS • 2023"),
              _certCard("Skills for Career Progression", "PCIU • 2022"),
              _certCard("Digital Marketing", "SR Dream IT • 2022"),
            ].map((c) => c.animate().fadeIn().slideY()).toList(),
          ),
        ],
      ),
    );
  }

  static Widget _certCard(String title, String subtitle) {
    return Container(
      width: 420.w,
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05), // works in both themes
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFF00E6A8).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified, color: const Color(0xFF00E6A8), size: 40),
          SizedBox(height: 16.h),
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}