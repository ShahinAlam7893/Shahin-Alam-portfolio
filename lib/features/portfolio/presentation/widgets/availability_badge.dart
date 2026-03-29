import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailabilityBadge extends StatelessWidget {
  final bool isAvailable;
  const AvailabilityBadge({super.key, this.isAvailable = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isAvailable ? const Color(0xFF00E6A8).withOpacity(0.2) : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 10, color: isAvailable ? const Color(0xFF00E6A8) : Colors.grey),
          SizedBox(width: 8.w),
          Text(isAvailable ? "Available for Opportunities" : "Currently Unavailable",
              style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    ).animate().fadeIn().shimmer(duration: 1500.ms, delay: 500.ms);
  }
}