import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/experience_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/profile_provider.dart';
import '../widgets/main_layout.dart';
import '../widgets/stat_card.dart';
import '../widgets/availability_badge.dart';
import '../widgets/project_card.dart';
import '../widgets/skill_group_card.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MainLayout(
      scrollController: _scrollController,   // Pass controller
      onNavTap: _scrollToSection,
      child: Column(
        children: [
          // ==================== HERO SECTION ====================
          SizedBox(height: 40.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 280.w,
                height: 280.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).primaryColor, width: 8),
                ),
                child: ClipOval(
                  child: Image.asset('assets/images/profile.jpg', fit: BoxFit.cover),
                ),
              ).animate().scale(duration: 900.ms),

              SizedBox(width: 60.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvailabilityBadge(isAvailable: true),
                    SizedBox(height: 30.h),

                    Text(
                      "Hi, I'm ${profile.name}",
                      style: TextStyle(fontSize: 68.sp, fontWeight: FontWeight.bold),
                    ).animate().fadeIn(),

                    Text(
                      profile.title,
                      style: TextStyle(fontSize: 34.sp, color: Theme.of(context).primaryColor),
                    ),

                    SizedBox(height: 30.h),
                    Text(profile.about, style: TextStyle(fontSize: 18.sp, height: 1.7)),
                    
                    SizedBox(height: 50.h),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => launchUrl(Uri.file('assets/resume.pdf')),
                          icon: const Icon(Icons.download),
                          label: const Text("Download Resume"),
                        ),
                        SizedBox(width: 20.w),
                        OutlinedButton.icon(
                          onPressed: () => _scrollToSection(2800), // Scroll to Contact
                          icon: const Icon(Icons.mail),
                          label: const Text("Let's Connect"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 120.h),

          // ==================== STATS ====================
          Wrap(
            spacing: 24.w,
            runSpacing: 24.h,
            children: const [
              StatCard(icon: Icons.work, value: "5+", label: "Years Experience"),
              StatCard(icon: Icons.rocket_launch, value: "10+", label: "Projects"),
              StatCard(icon: Icons.analytics, value: "96%", label: "Best Accuracy"),
              StatCard(icon: Icons.school, value: "3+", label: "Research"),
            ],
          ),

          SizedBox(height: 140.h),

          // ==================== SKILLS SECTION ====================
          _buildSectionTitle("Technical Skills"),
          Wrap(
            spacing: 24.w,
            runSpacing: 24.h,
            children: profile.skills.entries.map((e) => 
              SkillGroupCard(title: e.key, skills: e.value)
            ).toList(),
          ),

          SizedBox(height: 140.h),

          // ==================== PROJECTS SECTION ====================
          _buildSectionTitle("Featured Projects"),
          ...profile.projects.map((p) => Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: ProjectCard(
              title: p["title"],
              date: p["date"],
              description: '', technologies: [],
            ),
          )),

          SizedBox(height: 140.h),

          // ==================== EXPERIENCE SECTION ====================
          _buildSectionTitle("Experience"),
          ...profile.experiences.map((e) => ExperienceCard(
            role: e["role"],
            company: e["company"],
            date: e["date"],
            desc: e["desc"],
          )),

          SizedBox(height: 140.h),

          // ==================== EDUCATION SECTION ====================
          _buildSectionTitle("Education"),
          ...profile.education.map((edu) => Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(edu["degree"]!, style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600)),
                Text(edu["institute"]!, style: TextStyle(fontSize: 20.sp)),
                Text(edu["date"]!),
                Text(edu["grade"]!, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          )),

          SizedBox(height: 140.h),

          // ==================== ACHIEVEMENTS & CONTACT ====================
          _buildSectionTitle("Achievements"),
          // Add your achievements cards here...

          SizedBox(height: 100.h),
          _buildSectionTitle("Get In Touch"),
          // Contact section...
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.h),
      child: Text(
        title,
        style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold),
      ).animate().fadeIn().slideY(),
    );
  }
}