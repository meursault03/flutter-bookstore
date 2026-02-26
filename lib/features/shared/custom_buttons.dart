import 'package:flutter/material.dart';
import 'package:login_screen/features/shared/text_styles.dart';

/// Botão com gradiente e bordas arredondadas para telas principais.
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

/// Botão secundário com borda, sem preenchimento, para ações como "Adicionar ao Carrinho".
class OutlinedRoundButton extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color textColor;
  final void Function()? onPressed;

  const OutlinedRoundButton(
    this.text, {
    super.key,
    this.borderColor = const Color(0XFF0F51FA),
    this.textColor = const Color(0XFF0F51FA),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: StyleText(
          text,
          18,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
