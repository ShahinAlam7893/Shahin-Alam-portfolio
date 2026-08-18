import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahin_portfolio/core/theme/app_colors.dart';
import '../cursor/scramble_text.dart';

/// Consistent section title: a small accented "eyebrow" label above a large
/// heading that scrambles on hover.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? eyebrow;
  const SectionHeader({super.key, required this.title, this.eyebrow});

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accent(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (eyebrow != null) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 28, height: 2, color: accent),
              SizedBox(width: 10.w),
              Text(
                eyebrow!.toUpperCase(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  color: accent,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
        ],
        ScrambleText(
          title,
          style: TextStyle(
            fontSize: 34.sp,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}
