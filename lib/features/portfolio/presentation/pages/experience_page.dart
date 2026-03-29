import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/main_layout.dart';
import '../providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final experiences = Provider.of<ProfileProvider>(context).experiences;

    return MainLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Professional Journey", style: TextStyle(fontSize: 52.sp, fontWeight: FontWeight.bold))
              .animate().fadeIn().slideY(),

          SizedBox(height: 50.h),

          ...experiences.asMap().entries.map((entry) {
            final exp = entry.value;
            final index = entry.key;
            return Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(exp["role"]!, style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600)),
                      Text(exp["date"]!, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Text(exp["company"]!, style: TextStyle(fontSize: 20.sp, color: Theme.of(context).primaryColor)),
                  SizedBox(height: 20.h),
                  Text(exp["desc"]!, style: TextStyle(fontSize: 17.sp, height: 1.6)),
                ],
              ),
            ).animate().fadeIn(delay: (index * 150).ms).slideY(begin: 30);
          }).toList(),
        ],
      ),
    );
  }
}