import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shahin_portfolio/core/responsive/breakpoints.dart';

enum AppViewMode { website, mobile }

/// Controls whether the portfolio is shown in the wide "Website" layout or the
/// single-column "Mobile" layout.
///
/// - On first ever load we auto-detect from the viewport width
///   ([applyAutoDetect]) so phones get the mobile layout and desktops get the
///   website layout.
/// - Once the user explicitly toggles, that choice is persisted and always wins
///   over auto-detection (mirrors [ThemeProvider]'s prefs pattern).
class ViewModeProvider extends ChangeNotifier {
  static const _prefsKey = 'viewMode';

  AppViewMode _mode = AppViewMode.website;
  bool _hasStoredChoice = false;

  AppViewMode get mode => _mode;
  bool get isMobile => _mode == AppViewMode.mobile;
  bool get isWebsite => _mode == AppViewMode.website;

  /// True once the user has made an explicit choice (so auto-detect is skipped).
  bool get hasStoredChoice => _hasStoredChoice;

  ViewModeProvider() {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(_prefsKey);
      if (stored != null) {
        _mode = stored == 'mobile' ? AppViewMode.mobile : AppViewMode.website;
        _hasStoredChoice = true;
        notifyListeners();
      }
    } catch (_) {
      // Ignore – fall back to the current default.
    }
  }

  /// One-time, device-based default. No-op once the user has chosen.
  void applyAutoDetect(double width) {
    if (_hasStoredChoice) return;
    final detected =
        width < Breakpoints.mobile ? AppViewMode.mobile : AppViewMode.website;
    if (detected != _mode) {
      _mode = detected;
      notifyListeners();
    }
  }

  void toggle() => setMode(isMobile ? AppViewMode.website : AppViewMode.mobile);

  void setMode(AppViewMode mode) {
    final changed = _mode != mode;
    _mode = mode;
    _hasStoredChoice = true;
    _save();
    if (changed) notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _prefsKey,
        _mode == AppViewMode.mobile ? 'mobile' : 'website',
      );
    } catch (_) {
      // Ignore save errors.
    }
  }
}
