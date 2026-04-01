// lib/features/portfolio/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/providers/profile_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/theme_provider.dart';
import '../widgets/ios_device_frame.dart';
import '../widgets/portfolio_inside_phone.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFullScreen = false;

  Future<void> _openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Widget _buildSocialLinks(ProfileProvider profile, bool isDark) {
    final iconColor = isDark ? Colors.white : Colors.black87;

    return Row(
      children: [
        IconButton(
          onPressed: () => _openLink(profile.github),
          icon: FaIcon(FontAwesomeIcons.github, color: iconColor),
          tooltip: "GitHub",
        ),
        IconButton(
          onPressed: () => _openLink(profile.linkedin),
          icon: FaIcon(FontAwesomeIcons.linkedin, color: iconColor),
          tooltip: "LinkedIn",
        ),
        IconButton(
          onPressed: () => _openLink(profile.researchgate),
          icon: FaIcon(FontAwesomeIcons.researchgate, color: iconColor),
          tooltip: "ResearchGate",
        ),
      ],
    ).animate().fadeIn().slideX(begin: -0.2);
  }

  Future<void> _downloadResume() async {
    final byteData = await rootBundle.load('assets/resume/SHAHIN_ALAM.pdf');
    final bytes = byteData.buffer.asUint8List();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "SHAHIN_ALAM.pdf")
      ..click();

    html.Url.revokeObjectUrl(url);
  }

  List<Widget> _buildButtons(bool isDark, ThemeProvider themeProvider) {
    return [
      ElevatedButton.icon(
        onPressed: _downloadResume,
        icon: Icon(Icons.download_rounded,
            color: isDark ? Colors.black : Colors.white),
        label: Text(
          "Download Resume",
          style: TextStyle(color: isDark ? Colors.black : Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.white : const Color(0xFF0A2540),
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
        ),
      ),
      _isFullScreen
          ? ElevatedButton.icon(
              onPressed: () => setState(() => _isFullScreen = false),
              icon: Icon(Icons.fullscreen_exit,
                  color: isDark ? Colors.black : Colors.white),
              label: Text("Exit Full Screen",
                  style:
                      TextStyle(color: isDark ? Colors.black : Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDark ? Colors.white : const Color(0xFF0A2540),
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              ),
            )
          : ElevatedButton.icon(
              onPressed: () => setState(() => _isFullScreen = true),
              icon: Icon(Icons.fullscreen_rounded,
                  color: isDark ? Colors.black : Colors.white),
              label: Text("View in Full Screen",
                  style:
                      TextStyle(color: isDark ? Colors.black : Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDark ? Colors.white : const Color(0xFF0A2540),
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 18.h),
              ),
            ),
      IconButton(
        icon: Icon(
          isDark ? Icons.light_mode : Icons.dark_mode,
          size: 32,
          color: isDark ? Colors.white : Colors.black87,
        ),
        onPressed: () => themeProvider.toggleTheme(),
      ).animate().rotate(duration: 400.ms),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    final profile = Provider.of<ProfileProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0A2540), const Color(0xFF05121F)]
                : [const Color(0xFFF0F4F8), const Color(0xFFDDE6F0)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header section with profile pic, name, title, social links, and action buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = constraints.maxWidth < 900;

                    if (isMobile) {
                      // MOBILE VIEW
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 80.r,
                            backgroundImage:
                                const AssetImage('assets/images/profile.jpg'),
                          )
                              .animate()
                              .fadeIn()
                              .scale(begin: const Offset(0.8, 0.8)),
                          SizedBox(height: 20.h),
                          Text(
                            "SHAHIN ALAM",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40.sp, fontWeight: FontWeight.bold),
                          ).animate().fadeIn().slideY(begin: 20),
                          SizedBox(height: 8.h),
                          Text(
                            "Flutter Developer & AI Researcher",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          _buildSocialLinks(profile, isDark),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 12.w,
                            runSpacing: 12.h,
                            children: _buildButtons(isDark, themeProvider),
                          ),
                        ],
                      );
                    } else {
                      // DESKTOP VIEW (same design, fixed overflow)
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center, 
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center, 
                              children: [
                                CircleAvatar(
                                  radius: 80.r,
                                  backgroundImage: const AssetImage(
                                      'assets/images/profile.jpg'),
                                )
                                    .animate()
                                    .fadeIn()
                                    .scale(begin: const Offset(0.8, 0.8)),
                                SizedBox(width: 24.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "SHAHIN ALAM",
                                        style: TextStyle(
                                          fontSize: 48.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ).animate().fadeIn().slideY(begin: 20),
                                      SizedBox(height: 8.h),
                                      Text(
                                        "Flutter Developer & AI Researcher",
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                      _buildSocialLinks(profile, isDark),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                              width: 40.w),

                          // RIGHT SIDE (BUTTONS)
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                crossAxisAlignment:
                                    WrapCrossAlignment.center, 
                                spacing: 16.w,
                                runSpacing: 12.h,
                                children: _buildButtons(isDark, themeProvider),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),

              //Device Frame Section
              Expanded(
                child: IOSDeviceFrame(
                  isFullScreen: _isFullScreen,
                  onFullScreenTap: () =>
                      setState(() => _isFullScreen = !_isFullScreen),
                  child: PortfolioInsidePhone(
                    onFullScreenTap: () => setState(() => _isFullScreen = true),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
