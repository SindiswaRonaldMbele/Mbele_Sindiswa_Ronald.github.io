import 'package:flutter/material.dart';
import '../../data/category_data.dart';
import '../../services/firestore_service.dart';
import '../../shared/animated_page.dart';
import '../../shared/app_shell.dart';
import '../../shared/portfolio_item_card.dart';
import '../../shared/responsive_grid.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});
  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String selected = 'All';

  @override
  Widget build(BuildContext context) {
    final service = FirestoreService('projects');
    final categories = ['All', ...CategoryData.mainCategories];
    return AppShell(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: AnimatedPage(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('All Projects', style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  for (final category in categories)
                    FilterChip(selected: selected == category, label: Text(category), onSelected: (_) => setState(() => selected = category)),
                ]),
                const SizedBox(height: 24),
                StreamBuilder(
                  stream: service.watchItems(),
                  builder: (context, snapshot) {
                    final all = snapshot.data ?? [];
                    final items = selected == 'All' ? all : all.where((item) => item.mainCategory == selected).toList();
                    if (items.isEmpty) return const Card(child: Padding(padding: EdgeInsets.all(22), child: Text('No projects yet. Add them from /admin.')));
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
