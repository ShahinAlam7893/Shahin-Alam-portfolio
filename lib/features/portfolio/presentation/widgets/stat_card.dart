// lib/features/portfolio/presentation/widgets/stat_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 230.w,
        padding: EdgeInsets.all(28.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.85),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 42,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 16.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 34.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.85),
              ),
            ),
          ],
        ),
      )
          .animate()
          .scale(begin: const Offset(0.92, 0.92), duration: 400.ms)
          .then() // Add subtle feedback on tap
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(0.97, 0.97),
            duration: 100.ms,
          )
          .then()
          .scale(
            begin: const Offset(0.97, 0.97),
            end: const Offset(1.0, 1.0),
            duration: 150.ms,
          ),
    );
  }
}