import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/constants/admin_config.dart';
import '../../data/category_data.dart';
import '../../data/seed_data.dart';
import '../../models/portfolio_item.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../shared/app_shell.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final authService = AuthService();
  final projectService = FirestoreService('projects');

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: StreamBuilder<User?>(
        stream: authService.authState,
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) return _LoginCard(authService: authService);
          if (!authService.isAdmin(user)) {
            return Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text('This account is not authorised to edit.'),
                    const SizedBox(height: 8),
                    const Text('Admin account: ${AdminConfig.adminEmail}'),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () async {
                        try {
                          await authService.signInWithGoogle();
                        } catch (error) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Google sign-in failed: $error'),
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.login),
                      label: const Text('Sign in with Google'),
                    ),
                  ]),
                ),
              ),
            );
          }
          return _Dashboard(
              authService: authService, projectService: projectService);
        },
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard({required this.authService});
  final AuthService authService;
  @override
  Widget build(BuildContext context) => Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('Private Admin',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 10),
              const Text(
                  'Sign in to add, update or remove your portfolio content.'),
              const SizedBox(height: 18),
              FilledButton.icon(
                  onPressed: authService.signInWithGoogle,
                  icon: const Icon(Icons.login),
                  label: const Text('Sign in with Google')),
            ]),
          ),
        ),
      );
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({required this.authService, required this.projectService});
  final AuthService authService;
  final FirestoreService projectService;

  Future<void> _seedProjects() async {
    for (final item in SeedData.starterProjects) {
      await projectService.saveItem(item);
    }
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1050),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Admin Dashboard',
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 8),
              const Text('Only you can add, edit and delete portfolio items.'),
              const SizedBox(height: 18),
              Wrap(spacing: 12, runSpacing: 12, children: [
                FilledButton.icon(
                    onPressed: () => _openEditor(context, projectService),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Project')),
                OutlinedButton.icon(
                    onPressed: _seedProjects,
                    icon: const Icon(Icons.auto_fix_high),
                    label: const Text('Add Starter Projects')),
                OutlinedButton.icon(
                    onPressed: authService.signOut,
                    icon: const Icon(Icons.logout),
                    label: const Text('Sign Out')),
              ]),
              const SizedBox(height: 24),
              StreamBuilder(
                stream: projectService.watchItems(),
                builder: (context, snapshot) {
                  final items = snapshot.data ?? [];
                  if (items.isEmpty)
                    return const Card(
                        child: Padding(
                            padding: EdgeInsets.all(22),
                            child: Text('No projects yet.')));
                  return Column(children: [
                    for (final item in items)
                      Card(
                        child: ListTile(
                          title: Text(item.title),
                          subtitle: Text(
                              '${item.mainCategory} • ${item.subCategory}'),
                          trailing: Wrap(children: [
                            IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                onPressed: () =>
                                    _openEditor(context, projectService, item)),
                            IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () =>
                                    projectService.deleteItem(item.id)),
                          ]),
                        ),
                      ),
                  ]);
                },
              ),
            ]),
          ),
        ),
      );

  void _openEditor(BuildContext context, FirestoreService service,
          [PortfolioItem? item]) =>
      showDialog(
          context: context,
          builder: (_) => _ProjectEditor(service: service, existing: item));
}

class _ProjectEditor extends StatefulWidget {
  const _ProjectEditor({required this.service, this.existing});
  final FirestoreService service;
  final PortfolioItem? existing;
  @override
  State<_ProjectEditor> createState() => _ProjectEditorState();
}

class _ProjectEditorState extends State<_ProjectEditor> {
  late final TextEditingController title;
  late final TextEditingController description;
  late final TextEditingController longDescription;
  late final TextEditingController subCategory;
  late final TextEditingController tags;
  late final TextEditingController technologies;
  late final TextEditingController status;
  late final TextEditingController date;
  late final TextEditingController link;
  late String mainCategory;

  @override
  void initState() {
    super.initState();
    final item = widget.existing;
    mainCategory = item?.mainCategory ?? CategoryData.mainCategories.first;
    title = TextEditingController(text: item?.title ?? '');
    description = TextEditingController(text: item?.description ?? '');
    longDescription = TextEditingController(text: item?.longDescription ?? '');
    subCategory = TextEditingController(text: item?.subCategory ?? '');
    tags = TextEditingController(text: item?.tags.join(', ') ?? '');
    technologies =
        TextEditingController(text: item?.technologies.join(', ') ?? '');
    status = TextEditingController(text: item?.status ?? 'Planned');
    date = TextEditingController(text: item?.date ?? '');
    link = TextEditingController(text: item?.link ?? '');
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.existing == null ? 'Add Project' : 'Edit Project'),
        content: SizedBox(
          width: 640,
          child: SingleChildScrollView(
            child: Column(children: [
              _field(title, 'Title'),
              _field(description, 'Short description'),
              _field(longDescription, 'Detailed description', maxLines: 4),
              DropdownButtonFormField<String>(
                initialValue: mainCategory,
                decoration: const InputDecoration(labelText: 'Main category'),
                items: [
                  for (final category in CategoryData.mainCategories)
                    DropdownMenuItem(value: category, child: Text(category))
                ],
                onChanged: (value) =>
                    setState(() => mainCategory = value ?? mainCategory),
              ),
              const SizedBox(height: 10),
              _field(subCategory, 'Subcategory'),
              _field(tags, 'Tags separated by commas'),
              _field(technologies, 'Technologies separated by commas'),
              _field(status, 'Status'),
              _field(date, 'Date'),
              _field(link, 'Project link'),
            ]),
          ),
        ),
        actions: [
          TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel')),
          FilledButton(onPressed: _save, child: const Text('Save')),
        ],
      );

  Widget _field(TextEditingController controller, String label,
          {int maxLines = 1}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(labelText: label)),
      );

  Future<void> _save() async {
    final generatedId =
        title.text.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-');
    final item = PortfolioItem(
      id: widget.existing?.id ?? generatedId,
      title: title.text.trim(),
      description: description.text.trim(),
      longDescription: longDescription.text.trim(),
      mainCategory: mainCategory,
      subCategory: subCategory.text.trim(),
      tags: _split(tags.text),
      technologies: _split(technologies.text),
      status: status.text.trim(),
      date: date.text.trim(),
      link: link.text.trim(),
    );
    await widget.service.saveItem(item);
    if (mounted) Navigator.of(context).pop();
  }

  List<String> _split(String value) =>
      value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
}
