import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../features/admin/admin_page.dart';
import '../features/pages/achievements_page.dart';
import '../features/pages/category_page.dart';
import '../features/pages/certifications_page.dart';
import '../features/pages/contact_page.dart';
import '../features/pages/education_page.dart';
import '../features/pages/experience_page.dart';
import '../features/pages/home_page.dart';
import '../features/pages/projects_page.dart';
import '../features/pages/skills_page.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});
  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode themeMode = ThemeMode.system;
  void toggleTheme() => setState(() => themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return ThemeController(
      themeMode: themeMode,
      toggleTheme: toggleTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sindiswa Ronald Mbele',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
        initialRoute: '/',
        routes: {
          '/': (_) => const HomePage(),
          '/data': (_) => const CategoryPage(title: 'Data', subtitle: 'Data Science, Data Analytics, AI, BI and visualisation.', collectionCategory: 'Data', icon: Icons.analytics_outlined),
          '/software': (_) => const CategoryPage(title: 'Software Development', subtitle: 'Computer Science, Flutter, web apps, databases and algorithms.', collectionCategory: 'Software Development', icon: Icons.code_outlined),
          '/it': (_) => const CategoryPage(title: 'Information Technology', subtitle: 'Technical support, systems, networking and IT operations.', collectionCategory: 'Information Technology', icon: Icons.dns_outlined),
          '/mathematics': (_) => const CategoryPage(title: 'Mathematics and Modelling', subtitle: 'Applied mathematics, numerical methods and computational modelling.', collectionCategory: 'Mathematics and Modelling', icon: Icons.functions_outlined),
          '/projects': (_) => const ProjectsPage(),
          '/education': (_) => const EducationPage(),
          '/skills': (_) => const SkillsPage(),
          '/experience': (_) => const ExperiencePage(),
          '/certifications': (_) => const CertificationsPage(),
          '/achievements': (_) => const AchievementsPage(),
          '/contact': (_) => const ContactPage(),
          '/owaphembangamakhandamadoda': (_) => const AdminPage(),
        },
      ),
    );
  }
}

class ThemeController extends InheritedWidget {
  const ThemeController({required this.themeMode, required this.toggleTheme, required super.child, super.key});
  final ThemeMode themeMode;
  final VoidCallback toggleTheme;
  static ThemeController of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ThemeController>()!;
  @override
  bool updateShouldNotify(ThemeController oldWidget) => themeMode != oldWidget.themeMode;
}
