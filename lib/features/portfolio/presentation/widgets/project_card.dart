// lib/features/portfolio/presentation/widgets/project_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final List<String> tech;

  const ProjectCard({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    required this.tech,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.85), // Glass effect
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24.r),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(28.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 24.sp, fontWeight: FontWeight.w700),
                        ),
                      ),
                      // Text(
                      //   date,
                      //   style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                      // ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 16.sp, height: 1.6),
                  ),
                  SizedBox(height: 24.h),
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 8.h,
                    children: tech
                        .map((t) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Text(
                                t,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 30);
  }
}
