import 'package:flutter/material.dart';

/// Wraps [child] in Center > ConstrainedBox so content stays narrow on wide
/// screens. On mobile the parent is already narrower than [maxWidth], so this
/// is effectively a no-op.
class ResponsiveCenter extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const ResponsiveCenter({
    super.key,
    this.maxWidth = 600,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
