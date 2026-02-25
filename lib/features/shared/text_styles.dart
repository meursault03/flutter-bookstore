import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Texto estilizado com a fonte Inter, centralizado automaticamente.
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

/// Variante não centralizada do StyleText para alinhamentos customizados.
class StyleTextUnaligned extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const StyleTextUnaligned(
    this.text,
    this.fontSize, {
    this.color = Colors.white,
    required this.fontWeight,
    this.maxLines,
    this.overflow,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
