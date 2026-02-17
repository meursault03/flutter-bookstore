import 'package:flutter/material.dart';
import 'package:login_screen/features/login/components/auth.dart';

import 'helper.dart';

/// Cabeçalho das telas de autenticação.
///
/// Ocupa 30% da altura útil da tela. Usado para exibir títulos
/// e mensagens de boas-vindas nas telas de login/signup/reset.
/// Padding horizontal de 20px já incluso.
class AuthHeader extends StatelessWidget {
  final Widget child;

  const AuthHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final usableHeight = ScreenHelper.getUsableHeight(context);

    return Container(
      height: usableHeight * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: child,
    );
  }
}

/// Container principal das telas de autenticação.
///
/// Ocupa 70% da altura útil da tela. Fundo branco com bordas
/// arredondadas no topo, criando efeito de "card" sobre o gradiente.
/// Padding horizontal de 20px já incluso.
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

    return Container(
      height: usableHeight * 0.7,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: child,
      ),
    );
  }
}

/// Container com fundo gradiente.
///
/// Usado como background principal de telas. Recebe dois colors
/// e aplica um LinearGradient da esquerda para direita.
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
