import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/portfolio/presentation/providers/profile_provider.dart';
import 'features/portfolio/presentation/providers/theme_provider.dart';
import 'features/portfolio/presentation/pages/home_page.dart';
import 'features/portfolio/presentation/pages/education_page.dart';
import 'features/portfolio/presentation/pages/experience_page.dart';
import 'features/portfolio/presentation/pages/skills_page.dart';
import 'features/portfolio/presentation/pages/projects_page.dart';
import 'features/portfolio/presentation/pages/achievements_page.dart';
import 'features/portfolio/presentation/pages/certifications_page.dart';
import 'features/portfolio/presentation/pages/contact_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/education', builder: (_, __) => const EducationPage()),
    GoRoute(path: '/experience', builder: (_, __) => const ExperiencePage()),
    GoRoute(path: '/skills', builder: (_, __) => const SkillsPage()),
    GoRoute(path: '/projects', builder: (_, __) => const ProjectsPage()),
    GoRoute(path: '/achievements', builder: (_, __) => const AchievementsPage()),
    GoRoute(path: '/certifications', builder: (_, __) => const CertificationsPage()),
    GoRoute(path: '/contact', builder: (_, __) => const ContactPage()),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) => MaterialApp.router(
            title: 'Shahin Alam - Flutter Developer & AI Researcher',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}