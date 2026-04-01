// lib/features/portfolio/presentation/widgets/ios_device_frame.dart
import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IOSDeviceFrame extends StatelessWidget {
  final Widget child;
  final bool isFullScreen;
  final VoidCallback onFullScreenTap;

  const IOSDeviceFrame({
    super.key,
    required this.child,
    this.isFullScreen = false,
    required this.onFullScreenTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isFullScreen) {
      return child;
    }

    return Center(
      child: DeviceFrame(
        device: Devices.ios.iPhone14Pro,
        screen: child,
        orientation: Orientation.portrait,
      )
          .animate()
          .fadeIn(duration: 1200.ms)
          .scale(begin: const Offset(0.75, 0.75), curve: Curves.elasticOut),
    );
  }
}