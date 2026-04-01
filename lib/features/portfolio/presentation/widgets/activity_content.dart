// lib/features/portfolio/presentation/widgets/certifications_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/providers/profile_provider.dart';

class ActivityContent extends StatelessWidget {
  const ActivityContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Leadership & Activities",
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 30.h),
          ...profile.activities.map((activity) {
            return _activityCard(
              activity["title"]!,
              activity["issuer"]!,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _activityCard(String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ListTile(
        leading: const Icon(Icons.volunteer_activism, size: 40),
        title: Text(title, style: TextStyle(fontSize: 30.sp)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
