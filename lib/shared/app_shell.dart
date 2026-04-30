import 'package:flutter/material.dart';
import '../app/portfolio_app.dart';
import '../data/profile_data.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});
  final Widget child;

  static const Map<String, String> routes = {
    'Home': '/',
    'Data': '/data',
    'Software': '/software',
    'IT': '/it',
    'Math': '/mathematics',
    'Projects': '/projects',
    'Education': '/education',
    'Skills': '/skills',
    'Experience': '/experience',
    'Contact': '/contact',
  };

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 980;
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProfileData.fullName),
        actions: [
          if (isWide)
            for (final entry in routes.entries)
              TextButton(onPressed: () => Navigator.of(context).pushNamed(entry.value), child: Text(entry.key)),
          IconButton(onPressed: ThemeController.of(context).toggleTheme, icon: const Icon(Icons.brightness_6_outlined)),
        ],
      ),
      drawer: isWide
          ? null
          : Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(child: Text(ProfileData.fullName)),
                  for (final entry in routes.entries)
                    ListTile(title: Text(entry.key), onTap: () => Navigator.of(context).pushNamed(entry.value)),
                ],
              ),
            ),
      body: Stack(children: [const Positioned.fill(child: _AnimatedBackground()), Positioned.fill(child: child)]),
    );
  }
}

class _AnimatedBackground extends StatelessWidget {
  const _AnimatedBackground();
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(seconds: 5),
      curve: Curves.easeInOut,
      builder: (context, value, child) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1 + value * 0.2, -1),
            end: Alignment(1, 1 - value * 0.2),
            colors: [
              // ignore: deprecated_member_use
              scheme.primaryContainer.withOpacity(0.30),
              scheme.surface,
              // ignore: deprecated_member_use
              scheme.secondaryContainer.withOpacity(0.28),
              // ignore: deprecated_member_use
              scheme.tertiaryContainer.withOpacity(0.22),
            ],
          ),
        ),
      ),
    );
  }
}
