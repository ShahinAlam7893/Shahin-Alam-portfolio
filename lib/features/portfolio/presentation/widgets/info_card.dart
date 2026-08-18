import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahin_portfolio/core/theme/app_colors.dart';

/// Compact icon + title + subtitle card used for achievements, certifications
/// and activities. Theme-aware surface so it's visible in both light and dark.
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accent(context);
    final subColor =
        Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7);

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 24, color: accent),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700)),
                SizedBox(height: 4.h),
                Text(subtitle, style: TextStyle(fontSize: 14.sp, color: subColor)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.04);
  }
}
