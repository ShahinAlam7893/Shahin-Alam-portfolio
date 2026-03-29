import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/providers/profile_provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/main_layout.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final education = Provider.of<ProfileProvider>(context).education;

    return MainLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Education", style: TextStyle(fontSize: 52.sp, fontWeight: FontWeight.bold))
              .animate().fadeIn().slideY(begin: 20),

          SizedBox(height: 50.h),

          ...education.map((edu) => Container(
                margin: EdgeInsets.only(bottom: 40.h),
                padding: EdgeInsets.all(32.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border(left: BorderSide(color: Theme.of(context).primaryColor, width: 6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school, color: Theme.of(context).primaryColor, size: 32),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Text(edu["degree"]!, style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text("Graduate", style: TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(edu["institute"]!, style: TextStyle(fontSize: 20.sp)),
                    Text(edu["date"]!, style: const TextStyle(color: Colors.grey)),
                    SizedBox(height: 16.h),
                    Text(edu["grade"]!, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1)),
        ],
      ),
    );
  }
}