import 'package:flutter/material.dart';

import '../../shared/helper.dart';

/// Cabeçalho das telas de autenticação, ocupa 30% da altura útil.
/// Em telas largas o header é limitado a 200px para não ficar esticado.
class AuthHeader extends StatelessWidget {
  final Widget child;

  const AuthHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final usableHeight = ScreenHelper.getUsableHeight(context);
    final wide = ScreenHelper.isWideScreen(context);

    return Container(
      height: wide ? 200 : usableHeight * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: child,
    );
  }
}

/// Container branco com bordas arredondadas no topo, ocupa 70% da altura útil.
/// Em telas largas o height é determinado pelo conteúdo.
class AuthFormContainer extends StatelessWidget {
  final Widget child;
  final Color color;

  const AuthFormContainer({
    super.key,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final usableHeight = ScreenHelper.getUsableHeight(context);
    final wide = ScreenHelper.isWideScreen(context);

    return Container(
      height: wide ? null : usableHeight * 0.7,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: wide ? 24 : 0),
        child: child,
      ),
    );
  }
}

/// Container com gradiente linear, usado como fundo principal de telas.
class GradientContainer extends StatelessWidget {
  final Color firstColor;
  final Color secondColor;
  final Widget child;

  const GradientContainer(
    this.firstColor,
    this.secondColor, {
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [firstColor, secondColor],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      child: child,
    );
  }
}
