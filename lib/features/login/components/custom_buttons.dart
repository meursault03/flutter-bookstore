import 'package:flutter/material.dart';
import 'package:login_screen/features/login/components/text_styles.dart';

/// Botão com fundo gradiente e bordas arredondadas.
///
/// Componente reutilizável para CTAs (call-to-action) principais.
/// Altura fixa de 60px, largura se adapta ao pai.

class RoundButton extends StatelessWidget {
  final String text;
  final Color firstColor;
  final Color secondColor;
  final void Function()? onPressed;

  const RoundButton(
    this.text, {
    super.key,
    this.firstColor = const Color(0XFF0F51FA),
    this.secondColor = const Color(0XFF00B4EE),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          gradient: LinearGradient(colors: [firstColor, secondColor]),
        ),
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          child: StyleText(text, 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
