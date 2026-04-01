// lib/features/portfolio/presentation/widgets/portfolio_inside_phone.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/providers/navigation_provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/providers/theme_provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/achievements_content.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/activity_content.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/certifications_content.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/education_content.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/widgets/research_content.dart';
import 'home_content.dart';
import 'skills_content.dart';
import 'projects_content.dart';
import 'experience_content.dart';
import 'contact_content.dart';

class PortfolioInsidePhone extends StatelessWidget {
  final VoidCallback onFullScreenTap;
  const PortfolioInsidePhone({super.key, required this.onFullScreenTap});

  static const List<Widget> _screens = [
    HomeContent(),           
    SkillsContent(),        
    ProjectsContent(),       
    ExperienceContent(),     
    ContactContent(), 
    ResearchContent(),      
    AchievementsContent(),   
    CertificationsContent(),
    EducationContent(),
    ActivityContent(),
  ];

  // Map bottom nav index → screen index (bottom nav only has 5 items)
  static const List<int> _navToScreen = [0, 1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final navProvider = Provider.of<NavigationProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    // Determine which bottom nav item to highlight
    final screenIndex = navProvider.currentIndex;
    final bottomNavIndex = _navToScreen.contains(screenIndex)
        ? _navToScreen.indexOf(screenIndex)
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shahin Alam"),
        backgroundColor: const Color(0xFF0A2540),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(
  builder: (context, constraints) {
    double horizontalPadding;

    if (constraints.maxWidth > 1400) {
      horizontalPadding = 120;
    } else if (constraints.maxWidth > 1000) {
      horizontalPadding = 80;
    } else if (constraints.maxWidth > 600) {
      horizontalPadding = 40;
    } else {
      horizontalPadding = 16;
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: _screens[screenIndex],
        ),
      ),
    );
  },
),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        onTap: (index) => navProvider.navigateTo(_navToScreen[index]),
        selectedItemColor: isDark ? Colors.white : const Color(0xFF0A2540),
        unselectedItemColor: isDark ? Colors.grey[400] : Colors.grey[600],
        backgroundColor: isDark ? const Color(0xFF0A2540) : Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.code), label: "Skills"),
          BottomNavigationBarItem(icon: Icon(Icons.rocket_launch), label: "Projects"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Experience"),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Contact"),
        ],
      ),
    );
  }
}