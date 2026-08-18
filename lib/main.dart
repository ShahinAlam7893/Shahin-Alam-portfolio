// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/portfolio/presentation/shell/portfolio_shell.dart';
import 'features/portfolio/presentation/providers/navigation_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/portfolio/presentation/providers/profile_provider.dart';
import 'features/portfolio/presentation/providers/theme_provider.dart';
import 'features/portfolio/presentation/providers/view_mode_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ViewModeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => MaterialApp(
          title: 'Shahin Alam — Flutter Developer & AI Researcher',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          home: const PortfolioShell(),
        ),
      ),
    );
  }
}
