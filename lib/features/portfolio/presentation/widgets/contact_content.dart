// lib/features/portfolio/presentation/widgets/contact_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/providers/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/profile_provider.dart';

class ContactContent extends StatelessWidget {
  const ContactContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Get In Touch",
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30.h),

          // Contact Information
          _contactTile(Icons.phone, profile.phone),
          _contactTile(Icons.email, profile.email),
          _contactTile(Icons.location_on, profile.location),

          SizedBox(height: 40.h),

          // Social Links
          Text(
            "Connect with me",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20.h),

          _socialButton(
            icon: Icons.code,
            label: "GitHub",
            url: profile.github,
            // color: const Color(0xFF090d0a),
          ),
          SizedBox(height: 12.h),
          _socialButton(
            icon: Icons.link,
            label: "LinkedIn",
            url: profile.linkedin ??
                "https://www.linkedin.com/in/shahin-alam7892/", // fallback if not set
            // color: const Color(0xFF0A66C2),
          ),

          SizedBox(height: 40.h),

          // Email Button
          ElevatedButton.icon(
            onPressed: () => launchUrl(Uri.parse("mailto:${profile.email}")),
            icon:  Icon(Icons.send, color: isDark ? const Color(0xFF0A2540) : Colors.white),
            label: Text(
              "Send Email",
              style: TextStyle(fontSize: 18, color: isDark ? const Color(0xFF0A2540) : Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 60.h),
              backgroundColor: isDark ? Colors.white : const Color(0xFF0A2540),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactTile(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, size: 32),
      title: Text(text, style: TextStyle(fontSize: 24.sp)),
      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required String label,
    required String url,
    // required Color color,
  }) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          // color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16.r),
          // border: Border.all(color: color.withOpacity(0.3)
          //     // color: const Color(0xFF00D4FF).withOpacity(0.3),
          //     ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28),
            SizedBox(width: 16.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                // color: color,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
