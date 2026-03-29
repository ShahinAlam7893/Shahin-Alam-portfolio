import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatCard({super.key, required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15)],
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Theme.of(context).primaryColor),
          SizedBox(height: 12.h),
          Text(value, style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold)),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    ).animate().scale(begin: const Offset(0.8, 0.8), duration: 600.ms);
  }
}