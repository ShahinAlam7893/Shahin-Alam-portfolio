import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/profile_provider.dart';
import 'cursor/hover_region.dart';

/// Reusable row of social icons (used in the hero, contact section and footer).
class SocialLinks extends StatelessWidget {
  final double iconSize;
  final MainAxisAlignment alignment;
  const SocialLinks({
    super.key,
    this.iconSize = 20,
    this.alignment = MainAxisAlignment.start,
  });

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileProvider>();
    final color = Theme.of(context).textTheme.bodyLarge?.color;

    final links = [
      (FontAwesomeIcons.github, profile.github, 'GitHub'),
      (FontAwesomeIcons.linkedin, profile.linkedin, 'LinkedIn'),
      (FontAwesomeIcons.researchgate, profile.researchgate, 'ResearchGate'),
      (FontAwesomeIcons.solidEnvelope, 'mailto:${profile.email}', 'Email'),
    ];

    return Row(
      mainAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (icon, url, tip) in links)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: HoverRegion(
              cursorScale: 2.2,
              child: IconButton(
                onPressed: () => _open(url),
                icon: FaIcon(icon, size: iconSize, color: color),
                tooltip: tip,
              ),
            ),
          ),
      ],
    );
  }
}
