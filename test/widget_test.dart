// Basic smoke test: the app boots and renders the portfolio shell.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shahin_portfolio/main.dart';

void main() {
  testWidgets('App boots and renders hero name', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Let async providers (theme/view-mode prefs) and entrance-animation delays
    // run so no Future.delayed timers remain pending.
    await tester.pump(const Duration(milliseconds: 700));

    // The hero shows the developer's name.
    expect(find.textContaining('Shahin'), findsWidgets);

    // Dispose the tree so the continuously-repeating background animations
    // don't leave tickers/timers pending at teardown.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}
