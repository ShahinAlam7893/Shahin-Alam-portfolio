import 'package:flutter/widgets.dart';

/// Central place for responsive breakpoints and helpers.
///
/// NOTE: These read the ambient [MediaQuery] width and are used to decide
/// *layout* (single column vs multi column, paddings, nav style). Visual
/// *scaling* is handled separately by `flutter_screenutil` which is scoped
/// per view (see the shell layouts).
class Breakpoints {
  Breakpoints._();

  /// Below this width we treat the viewport as a phone.
  static const double mobile = 768;

  /// Below this width we treat the viewport as a tablet / small laptop.
  static const double tablet = 1100;

  /// Max width of the readable content column on large screens.
  static const double contentMaxWidth = 1160;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get isMobileWidth => screenWidth < Breakpoints.mobile;
  bool get isTabletWidth =>
      screenWidth >= Breakpoints.mobile && screenWidth < Breakpoints.tablet;
  bool get isDesktopWidth => screenWidth >= Breakpoints.tablet;

  /// Pick a value per breakpoint. [tablet] falls back to [desktop] when omitted.
  T responsive<T>({required T mobile, T? tablet, required T desktop}) {
    if (isMobileWidth) return mobile;
    if (isTabletWidth) return tablet ?? desktop;
    return desktop;
  }
}
