import 'package:flutter/material.dart';
import '../../shared/animated_page.dart';
import '../../shared/app_shell.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppShell(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: AnimatedPage(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Education', style: theme.textTheme.displaySmall),
                const SizedBox(height: 8),
                const Text('Dedicated screen for Education. This is not part of a long one-page layout.'),
                const SizedBox(height: 24),
                Card(child: Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Education overview', style: theme.textTheme.titleLarge), const SizedBox(height: 8), const Text('Add and expand content here as your portfolio grows.')]))),
                const SizedBox(height: 14),
                Card(child: Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Category labels', style: theme.textTheme.titleLarge), const SizedBox(height: 8), const Text('Data • Software Development • Information Technology • Mathematics and Modelling')]))),
                const SizedBox(height: 14),
                if ('Education' == 'Contact') ...[
                  const TextField(decoration: InputDecoration(labelText: 'Your name')),
                  const SizedBox(height: 12),
                  const TextField(decoration: InputDecoration(labelText: 'Your email')),
                  const SizedBox(height: 12),
                  const TextField(maxLines: 5, decoration: InputDecoration(labelText: 'Message')),
                  const SizedBox(height: 12),
                  const FilledButton(onPressed: null, child: Text('Form UI only')),
                ],
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
