// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/pages/home_page.dart';
import 'package:shahin_portfolio/features/portfolio/presentation/providers/navigation_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/portfolio/presentation/providers/profile_provider.dart';
import 'features/portfolio/presentation/providers/theme_provider.dart';

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
          ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) => MaterialApp(
            title: 'Shahin Alam - Flutter Developer & AI Researcher',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            // routerConfig: AppRoutes.router,
            home: const HomePage(),
          ),
        ),
      ),
    );
  }
}
