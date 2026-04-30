import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({required this.children, super.key});
  final List<Widget> children;

  int _count(double width) {
    if (width < 600) return 1;
    if (width <= 1024) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final count = _count(MediaQuery.sizeOf(context).width);
    return GridView.count(
      crossAxisCount: count,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 18,
      crossAxisSpacing: 18,
      childAspectRatio: count == 1 ? 1.35 : 1.05,
      children: children,
    );
  }
}
