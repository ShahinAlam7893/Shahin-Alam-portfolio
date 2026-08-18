// lib/features/portfolio/presentation/widgets/contact_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shahin_portfolio/core/theme/app_colors.dart';
import '../providers/profile_provider.dart';
import 'sections/section_header.dart';
import 'social_links.dart';
import 'cursor/hover_region.dart';

class ContactContent extends StatelessWidget {
  const ContactContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final accent = AppColors.accent(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Let\'s work together', eyebrow: 'Contact'),
        SizedBox(height: 18.h),
        Text(
          'Have a project in mind, or want to talk about Flutter and AI?\nI\'m always open to thoughtful conversations.',
          style: TextStyle(fontSize: 18.sp, height: 1.65),
        ),
        SizedBox(height: 28.h),
        LayoutBuilder(
          builder: (context, constraints) {
            final items = [
              (Icons.email_outlined, 'Email', profile.email),
              (Icons.phone_outlined, 'Phone', profile.phone),
              (Icons.location_on_outlined, 'Based in', profile.location),
            ];
            return Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                for (final item in items)
                  SizedBox(
                    width: constraints.maxWidth < 600
                        ? constraints.maxWidth
                        : (constraints.maxWidth - 28) / 3,
                    child: _ContactTile(
                      icon: item.$1,
                      label: item.$2,
                      value: item.$3,
                    ),
                  ),
              ],
            );
          },
        ),
        SizedBox(height: 30.h),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 20,
          runSpacing: 16,
          children: [
            HoverRegion(
              child: FilledButton.icon(
                onPressed: () => launchUrl(Uri.parse('mailto:${profile.email}')),
                icon: const Icon(Icons.send_rounded),
                label: const Text('Send an email'),
                style: FilledButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                ),
              ),
            ),
            SocialLinks(),
          ],
        ),
        SizedBox(height: 56.h),
        Text(
          '© ${DateTime.now().year} Shahin Alam. Built with Flutter.',
          style: TextStyle(fontSize: 12.sp, color: Theme.of(context).hintColor),
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accent(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        children: [
          Icon(icon, color: accent, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: Theme.of(context).hintColor)),
                const SizedBox(height: 3),
                Text(value, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
