import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomAnimatedBackground extends StatelessWidget {
  const CustomAnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Subtle moving grid / tech lines
        Positioned.fill(
          child: Opacity(
            opacity: isDark ? 0.15 : 0.08,
            child: GridPaper(
              color: Theme.of(context).primaryColor,
              divisions: 40,
              subdivisions: 2,
            ),
          ),
        ),

        // Floating glowing orbs (very subtle)
        Positioned(
          top: 100,
          left: 200,
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.12),
                  Colors.transparent,
                ],
              ),
            ),
          )
              .animate()
              .move(
                begin: const Offset(-50, -50),
                end: const Offset(80, 80),
                duration: 25.seconds,
                curve: Curves.easeInOutSine,
              )
              .fadeIn(),
        ),

        Positioned(
          bottom: 150,
          right: 150,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.08),
                  Colors.transparent,
                ],
              ),
            ),
          )
              .animate(
                onComplete: (controller) => controller.repeat(reverse: true),
              )
              .move(
                begin: const Offset(60, 60),
                end: const Offset(-40, -70),
                duration: 32.seconds,
                curve: Curves.easeInOutSine,
              ),
        ),

        // Very subtle floating particles
        ...List.generate(8, (index) {
          return Positioned(
            left: 100.0 + (index * 180),
            top: 200.0 + (index * 90),
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            )
                .animate(
                    onComplete: (controller) =>
                        controller.repeat(reverse: true))
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.8, 1.8),
                  duration: Duration(milliseconds: 1800 + index * 300),
                )
                .fadeIn(),
          );
        }),
      ],
    );
  }
}
