import 'package:flutter/material.dart';
import 'package:shahin_portfolio/core/theme/app_colors.dart';
import '../cursor/hover_region.dart';

/// Small circular "scroll to top" button shown after the user scrolls down.
class BackToTopButton extends StatelessWidget {
  final bool visible;
  final VoidCallback onTap;
  const BackToTopButton({super.key, required this.visible, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accent(context);
    return AnimatedSlide(
      duration: const Duration(milliseconds: 250),
      offset: visible ? Offset.zero : const Offset(0, 2),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: visible ? 1 : 0,
        child: HoverRegion(
          child: Material(
            color: accent,
            shape: const CircleBorder(),
            elevation: 6,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onTap,
              child: const SizedBox(
                width: 48,
                height: 48,
                child: Icon(Icons.arrow_upward_rounded, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
