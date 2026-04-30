import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  const HoverCard({required this.child, super.key});
  final Widget child;
  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        // ignore: deprecated_member_use
        transform: Matrix4.identity()..translate(0.0, hover ? -6.0 : 0.0)..scale(hover ? 1.015 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          // ignore: deprecated_member_use
          boxShadow: hover ? [BoxShadow(color: color.withOpacity(0.20), blurRadius: 30, offset: const Offset(0, 18))] : [],
        ),
        child: widget.child,
      ),
    );
  }
}
