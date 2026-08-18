import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/portfolio_sections.dart';
import '../widgets/single_page_scroller.dart';
import '../widgets/nav/top_nav_bar.dart';
import '../widgets/nav/back_to_top_button.dart';

/// Wide, single-page website layout: sticky top nav (outside the scroll view)
/// over one shared vertical scroll, with a floating back-to-top button.
class WebsiteLayout extends StatefulWidget {
  const WebsiteLayout({super.key});

  @override
  State<WebsiteLayout> createState() => _WebsiteLayoutState();
}

class _WebsiteLayoutState extends State<WebsiteLayout> {
  final GlobalKey<SinglePageScrollerState> _scrollerKey = GlobalKey();
  bool _showBackToTop = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      minTextAdapt: true,
      builder: (context, _) {
        final sections = buildSections();
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Column(
                children: [
                  TopNavBar(sections: sections),
                  Expanded(
                    child: SinglePageScroller(
                      key: _scrollerKey,
                      sections: sections,
                      topInset: 68,
                      onScrolledChanged: (v) =>
                          setState(() => _showBackToTop = v),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 28,
                bottom: 28,
                child: BackToTopButton(
                  visible: _showBackToTop,
                  onTap: () => _scrollerKey.currentState?.scrollToTop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
