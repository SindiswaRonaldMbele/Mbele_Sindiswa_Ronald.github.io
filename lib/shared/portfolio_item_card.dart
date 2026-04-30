import 'package:flutter/material.dart';
import '../models/portfolio_item.dart';
import 'hover_card.dart';

class PortfolioItemCard extends StatelessWidget {
  const PortfolioItemCard({required this.item, super.key});
  final PortfolioItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HoverCard(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(item.description),
              const SizedBox(height: 14),
              Wrap(spacing: 8, runSpacing: 8, children: [
                Chip(label: Text(item.mainCategory)),
                Chip(label: Text(item.subCategory)),
                Chip(label: Text(item.status)),
              ]),
              const SizedBox(height: 10),
              Wrap(spacing: 8, runSpacing: 8, children: [for (final tag in item.tags) InputChip(label: Text(tag))]),
              if (item.technologies.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text('Tech', style: theme.textTheme.labelLarge),
                Wrap(spacing: 8, children: [for (final tech in item.technologies) Chip(label: Text(tech))]),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
