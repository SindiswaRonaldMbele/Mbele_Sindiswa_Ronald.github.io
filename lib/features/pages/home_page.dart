import 'package:flutter/material.dart';
import '../../data/category_data.dart';
import '../../data/profile_data.dart';
import '../../shared/animated_page.dart';
import '../../shared/app_shell.dart';
import '../../shared/hover_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _route(String category) => switch (category) {
        'Data' => '/data',
        'Software Development' => '/software',
        'Information Technology' => '/it',
        _ => '/mathematics',
      };

  IconData _icon(String category) => switch (category) {
        'Data' => Icons.analytics_outlined,
        'Software Development' => Icons.code_outlined,
        'Information Technology' => Icons.dns_outlined,
        _ => Icons.functions_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppShell(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: AnimatedPage(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(34),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: LinearGradient(colors: [
                          // ignore: deprecated_member_use
                          theme.colorScheme.primaryContainer.withOpacity(0.85),
                          // ignore: deprecated_member_use
                          theme.colorScheme.secondaryContainer.withOpacity(0.72),
                          // ignore: deprecated_member_use
                          theme.colorScheme.tertiaryContainer.withOpacity(0.60),
                        ]),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ProfileData.fullName, style: theme.textTheme.displayMedium),
                          const SizedBox(height: 10),
                          Text(ProfileData.headline, style: theme.textTheme.headlineSmall),
                          const SizedBox(height: 14),
                          Text(ProfileData.summary, style: theme.textTheme.bodyLarge),
                          const SizedBox(height: 24),
                          Wrap(spacing: 12, runSpacing: 12, children: [
                            FilledButton.icon(onPressed: () => Navigator.of(context).pushNamed('/projects'), icon: const Icon(Icons.workspaces_outline), label: const Text('View All Projects')),
                            OutlinedButton.icon(onPressed: () => Navigator.of(context).pushNamed('/skills'), icon: const Icon(Icons.psychology_outlined), label: const Text('View Skills')),
                            OutlinedButton.icon(onPressed: () => Navigator.of(context).pushNamed('/contact'), icon: const Icon(Icons.mail_outline), label: const Text('Contact Me')),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text('Choose a Portfolio Path', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  Wrap(spacing: 18, runSpacing: 18, children: [
                    for (final category in CategoryData.mainCategories)
                      SizedBox(
                        width: 270,
                        child: HoverCard(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(22),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Icon(_icon(category), size: 34),
                                const SizedBox(height: 14),
                                Text(category, style: theme.textTheme.titleLarge),
                                const SizedBox(height: 8),
                                const Text('Open a dedicated page for this career direction.'),
                                const SizedBox(height: 16),
                                FilledButton.tonal(onPressed: () => Navigator.of(context).pushNamed(_route(category)), child: const Text('Open Page')),
                              ]),
                            ),
                          ),
                        ),
                      ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
