// lib/features/portfolio/presentation/providers/navigation_provider.dart
import 'package:flutter/material.dart';

/// Every scrollable section of the single-page portfolio, in display order.
enum SectionId {
  home,
  about,
  skills,
  projects,
  experience,
  education,
  research,
  achievements,
  certifications,
  activities,
  contact,
}

/// Drives single-page navigation: which section is currently active (for nav
/// highlighting) and requests to smooth-scroll to a section.
///
/// The [GlobalKey]s and [ScrollController] live in the shell's State — this
/// provider only holds the active id and a scroll-request callback the shell
/// registers.
class NavigationProvider extends ChangeNotifier {
  SectionId _active = SectionId.home;
  SectionId get active => _active;

  void Function(SectionId id)? _scrollHandler;

  void registerScrollHandler(void Function(SectionId id) handler) {
    _scrollHandler = handler;
  }

  /// Called by the shell's scroll listener to update nav highlighting.
  void setActive(SectionId id) {
    if (id != _active) {
      _active = id;
      notifyListeners();
    }
  }

  /// Called by nav links / stat cards to scroll the page to a section.
  void requestScrollTo(SectionId id) => _scrollHandler?.call(id);
}
