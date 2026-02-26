import 'package:flutter/material.dart';

///Impede o centro de esticar na tela toda
class ResponsiveCenter extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const ResponsiveCenter({super.key, this.maxWidth = 600, required this.child});

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
