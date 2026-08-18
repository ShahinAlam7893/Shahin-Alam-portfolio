// Responsiveness smoke tests: the app renders without overflow at phone,
// tablet and desktop widths, and the mobile hero name is visible on a phone.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shahin_portfolio/main.dart';

Future<void> _pumpAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const MyApp());
  await tester.pump(const Duration(milliseconds: 700));
}

Future<void> _dispose(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  final sizes = <String, Size>{
    'phone': const Size(390, 844),
    'tablet': const Size(800, 1000),
    'desktop': const Size(1440, 900),
  };

  sizes.forEach((label, size) {
    testWidgets('renders without overflow at $label width', (tester) async {
      await _pumpAt(tester, size);

      // No RenderFlex overflow (or any other) should have been thrown.
      expect(tester.takeException(), isNull);
      // Hero name is present.
      expect(find.textContaining('Shahin'), findsWidgets);

      await _dispose(tester);
    });
  });
}
