// lib/features/portfolio/presentation/widgets/availability_badge.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailabilityBadge extends StatelessWidget {
  final bool isAvailable;
  const AvailabilityBadge({super.key, this.isAvailable = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isAvailable 
            ? const Color(0xFF00E6A8).withOpacity(0.25)
            : Colors.grey.withOpacity(0.25),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: isAvailable ? const Color(0xFF00E6A8) : Colors.grey,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 12, color: isAvailable ? const Color(0xFF00E6A8) : Colors.grey),
          SizedBox(width: 10.w),
          Text(
            isAvailable ? "Available for Opportunities" : "Currently Unavailable",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
          ),
        ],
      ),
    ).animate().fadeIn().shimmer(duration: 2000.ms, delay: 300.ms);
  }
}