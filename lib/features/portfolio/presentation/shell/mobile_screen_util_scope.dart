import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Configures flutter_screenutil for the mobile design canvas using the ambient
/// [MediaQuery] (which, inside an IOSDeviceFrame, is the phone's ~393×852 logical
/// size). Use this for the in-frame mobile preview where a nested ScreenUtilInit
/// would bypass the frame's injected MediaQuery.
class MobileScreenUtilScope extends StatelessWidget {
  final Widget child;
  const MobileScreenUtilScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.configure(
      data: MediaQuery.of(context),
      designSize: const Size(390, 844),
    );
    return child;
  }
}
