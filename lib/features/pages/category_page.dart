import 'package:flutter/material.dart';
import '../../data/category_data.dart';
import '../../services/firestore_service.dart';
import '../../shared/animated_page.dart';
import '../../shared/app_shell.dart';
import '../../shared/portfolio_item_card.dart';
import '../../shared/responsive_grid.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({required this.title, required this.subtitle, required this.collectionCategory, required this.icon, super.key});

  final String title;
  final String subtitle;
  final String collectionCategory;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final service = FirestoreService('projects');
    final theme = Theme.of(context);
    final subcategories = CategoryData.subcategories[collectionCategory] ?? const [];
    return AppShell(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: AnimatedPage(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(icon, size: 48),
                const SizedBox(height: 12),
                Text(title, style: theme.textTheme.displaySmall),
                const SizedBox(height: 8),
                Text(subtitle, style: theme.textTheme.titleMedium),
                const SizedBox(height: 18),
                Wrap(spacing: 8, runSpacing: 8, children: [for (final item in subcategories) Chip(label: Text(item))]),
                const SizedBox(height: 28),
                Text('Projects in $title', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 16),
                StreamBuilder(
                  stream: service.watchItems(),
                  builder: (context, snapshot) {
                    final items = (snapshot.data ?? []).where((item) => item.mainCategory == collectionCategory).toList();
                    if (items.isEmpty) return const Card(child: Padding(padding: EdgeInsets.all(22), child: Text('No items yet. Add them from /admin.')));
                    return ResponsiveGrid(children: [for (final item in items) PortfolioItemCard(item: item)]);
                  },
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
