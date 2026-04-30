import 'package:flutter/material.dart';

class AnimatedPage extends StatelessWidget {
  const AnimatedPage({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) => Opacity(
          opacity: value,
          child: Transform.translate(offset: Offset(0, 28 * (1 - value)), child: child),
        ),
        child: child,
      );
}
