// lib/features/portfolio/presentation/widgets/home_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/core/theme/app_colors.dart';
import 'package:shahin_portfolio/core/utils/web_download.dart';
import '../providers/profile_provider.dart';
import '../providers/navigation_provider.dart';
import 'availability_badge.dart';
import 'social_links.dart';
import 'cursor/hover_region.dart';

class HomeContent extends StatelessWidget {
  final VoidCallback? onViewToggle;
  final bool isMobileView;
  const HomeContent({super.key, this.onViewToggle, this.isMobileView = false});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final nav = context.read<NavigationProvider>();
    final accent = AppColors.accent(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 680;
        final intro = Column(
          crossAxisAlignment:
              compact ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: compact ? 34.r : 42.r,
                  backgroundImage:
                      const AssetImage('assets/images/profile.jpg'),
                ).animate().fadeIn().scale(begin: const Offset(.8, .8)),
                SizedBox(width: 16.w),
                const AvailabilityBadge(isAvailable: true),
              ],
            ),
            SizedBox(height: 28.h),
            Text(
              "Hi, I'm",
              style: TextStyle(
                fontSize: compact ? 22.sp : 28.sp,
                color: accent,
                fontWeight: FontWeight.w600,
              ),
            ).animate().fadeIn(delay: 150.ms),
            SizedBox(height: 4.h),
            Text(
              profile.name,
              textAlign: compact ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                fontSize: compact ? 45.sp : 76.sp,
                fontWeight: FontWeight.w900,
                height: .98,
                letterSpacing: -1.5,
              ),
            ).animate().fadeIn(delay: 220.ms).slideY(begin: .12),
            SizedBox(height: 14.h),
            Text(
              profile.title,
              textAlign: compact ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                fontSize: compact ? 19.sp : 27.sp,
                color: accent,
                fontWeight: FontWeight.w600,
              ),
            ).animate().fadeIn(delay: 320.ms),
            SizedBox(height: 18.h),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                profile.about,
                textAlign: compact ? TextAlign.center : TextAlign.left,
                style: TextStyle(fontSize: compact ? 15.sp : 17.sp, height: 1.7),
              ),
            ),
            SizedBox(height: 26.h),
            Wrap(
              alignment: compact ? WrapAlignment.center : WrapAlignment.start,
              spacing: 12,
              runSpacing: 12,
              children: [
                MagneticButton(
                  onPressed: () => downloadAsset(
                    'assets/resume/SHAHIN_ALAM.pdf',
                    'SHAHIN_ALAM.pdf',
                    mimeType: 'application/pdf',
                  ),
                  child: FilledButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: const Text('Download Resume'),
                    style: FilledButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: accent,
                      disabledForegroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
                HoverRegion(
                  child: OutlinedButton.icon(
                    onPressed: () => nav.requestScrollTo(SectionId.contact),
                    icon: const Icon(Icons.arrow_outward_rounded, size: 18),
                    label: const Text('Let\'s talk'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color,
                      side: BorderSide(color: AppColors.border(context)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
                if (onViewToggle != null)
                  HoverRegion(
                    child: IconButton(
                      tooltip: isMobileView
                          ? 'Switch to website view'
                          : 'Switch to mobile view',
                      onPressed: onViewToggle,
                      icon: Icon(isMobileView
                          ? Icons.desktop_windows_outlined
                          : Icons.phone_iphone_outlined),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 14.h),
            SocialLinks(alignment: compact ? MainAxisAlignment.center : MainAxisAlignment.start),
          ],
        );

        final stats = [
          ('5+', 'Years building', Icons.work_outline, SectionId.experience),
          ('6+', 'Projects shipped', Icons.rocket_launch_outlined, SectionId.projects),
          ('3+', 'Research works', Icons.auto_graph_outlined, SectionId.research),
          ('3', 'Awards won', Icons.emoji_events_outlined, SectionId.achievements),
        ];
        final statRow = Wrap(
          alignment: compact ? WrapAlignment.center : WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final stat in stats)
              _HeroStat(
                value: stat.$1,
                label: stat.$2,
                icon: stat.$3,
                onTap: () => nav.requestScrollTo(stat.$4),
              ),
          ],
        );

        if (compact) {
          return Column(children: [intro, SizedBox(height: 38.h), statRow]);
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: intro),
            SizedBox(width: 40.w),
            Flexible(flex: 0, child: SizedBox(width: 360, child: statRow)),
          ],
        );
      },
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _HeroStat({required this.value, required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accent(context);
    return HoverRegion(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 170,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border(context)),
          ),
          child: Row(
            children: [
              Icon(icon, color: accent, size: 22),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  Text(label, style: TextStyle(fontSize: 11, color: Theme.of(context).textTheme.bodySmall?.color)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
