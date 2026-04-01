// lib/features/portfolio/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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

  Future<void> _downloadResume() async {
    final byteData = await rootBundle.load('assets/resume/SHAHIN_ALAM.pdf');
    final bytes = byteData.buffer.asUint8List();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

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
          child: Stack(
            children: [
              Column(
                children: [
                  // Header with Theme Toggle
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 80.r,
                              backgroundImage:
                                  const AssetImage('assets/images/profile.jpg'),
                            )
                                .animate()
                                .fadeIn()
                                .scale(begin: const Offset(0.8, 0.8)),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "SHAHIN ALAM",
                                  style: TextStyle(
                                      fontSize: 48.sp,
                                      fontWeight: FontWeight.bold),
                                ).animate().fadeIn().slideY(begin: 20),
                                SizedBox(height: 8.h),
                                Text(
                                  "Flutter Developer & AI Researcher",
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _downloadResume,
                              icon: const Icon(Icons.download_rounded),
                              label: const Text("Download Resume"),
                              style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 32.w, vertical: 16.h),
                                    ),
                            ),
                            SizedBox(width: 16.w),
                            _isFullScreen
                                ? ElevatedButton.icon(
                                    onPressed: () =>
                                        setState(() => _isFullScreen = false),
                                    icon: const Icon(Icons.fullscreen_exit),
                                    label: const Text("Exit Full Screen"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 32.w, vertical: 16.h),
                                    ),
                                  )
                                : ElevatedButton.icon(
                                    onPressed: () =>
                                        setState(() => _isFullScreen = true),
                                    icon: const Icon(Icons.fullscreen_rounded),
                                    label: const Text("View in Full Screen"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.w, vertical: 18.h),
                                    ),
                                  ),
                            SizedBox(width: 8.w),
                            IconButton(
                              icon: Icon(
                                isDark ? Icons.light_mode : Icons.dark_mode,
                                size: 32,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                              onPressed: () => themeProvider.toggleTheme(),
                            ).animate().rotate(duration: 400.ms),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // iOS Device Frame
                  Expanded(
                    child: IOSDeviceFrame(
                      isFullScreen: _isFullScreen,
                      onFullScreenTap: () =>
                          setState(() => _isFullScreen = !_isFullScreen),
                      child: PortfolioInsidePhone(
                        onFullScreenTap: () =>
                            setState(() => _isFullScreen = true),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
