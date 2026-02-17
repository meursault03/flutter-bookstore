import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Texto estilizado com a fonte Inter.
///
/// Componente reutilizável para manter consistência tipográfica no app.
/// Centraliza o texto automaticamente.
class StyleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  const StyleText(
    this.text,
    this.fontSize, {
    this.color = Colors.white,
    required this.fontWeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}

///Versão nao centralizada do StyleText, para casos onde o alinhamento precisa ser diferente.
class StyleTextUnaligned extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  const StyleTextUnaligned(
    this.text,
    this.fontSize, {
    this.color = Colors.white,
    required this.fontWeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
