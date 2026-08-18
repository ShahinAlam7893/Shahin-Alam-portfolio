import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'mobile_layout.dart';
import 'mobile_screen_util_scope.dart';

/// Desktop "Mobile view": renders the real [MobileLayout] inside an iPhone
/// mockup so a desktop visitor can preview the phone experience. The frame
/// injects a ~393×852 MediaQuery which [MobileScreenUtilScope] feeds to
/// flutter_screenutil so content renders at the right scale.
class MobileFramePreview extends StatelessWidget {
  const MobileFramePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: DeviceFrame(
          device: Devices.ios.iPhone14Pro,
          orientation: Orientation.portrait,
          screen: const MobileScreenUtilScope(
            child: MobileLayout(showViewToggle: true),
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms)
            .scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutCubic),
      ),
    );
  }
}
