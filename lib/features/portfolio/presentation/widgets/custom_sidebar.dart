import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/providers/profile_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class CustomSidebar extends StatelessWidget {
  const CustomSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    return Container(
      width: 380.w,
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.all(32.w),
      child: Column(
        children: [
          const SizedBox(height: 40),
          CircleAvatar(
            radius: 90.r,
            backgroundImage: const AssetImage('assets/images/profile.jpg'),
          ).animate().scale(duration: 800.ms),

          SizedBox(height: 24.h),
          Text(profile.name, style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold)),
          Text(profile.title, style: TextStyle(fontSize: 18.sp, color: Theme.of(context).primaryColor)),

          const Divider(height: 50),

          _buildContactItem(context, Icons.phone, profile.phone),
          _buildContactItem(context, Icons.email, profile.email),
          _buildContactItem(context, Icons.location_on, profile.location),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: const Icon(Icons.code), onPressed: () => launchUrl(Uri.parse("https://github.com"))),
              IconButton(icon: const Icon(Icons.link), onPressed: () => launchUrl(Uri.parse(profile.researchgate))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(children: [Icon(icon, size: 20), SizedBox(width: 16.w), Expanded(child: Text(text))]),
    ).animate().fadeIn(delay: 300.ms);
  }
}