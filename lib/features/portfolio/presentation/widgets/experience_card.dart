import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExperienceCard extends StatelessWidget {
  final String role;
  final String company;
  final String date;
  final String desc;

  const ExperienceCard({
    super.key,
    required this.role,
    required this.company,
    required this.date,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40.h),
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border(
          left: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 6,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Role + Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  role,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Company Name
          Text(
            company,
            style: TextStyle(
              fontSize: 20.sp,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 24.h),

          // Description
          Text(
            desc,
            style: TextStyle(
              fontSize: 17.sp,
              height: 1.65,
            ),
          ),

          // Optional: Add tech tags if you want
          // SizedBox(height: 20.h),
          // Wrap(
          //   spacing: 10.w,
          //   children: const [
          //     Chip(label: Text("Flutter")),
          //     Chip(label: Text("Firebase")),
          //   ],
          // ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 40, curve: Curves.easeOutCubic);
  }
}