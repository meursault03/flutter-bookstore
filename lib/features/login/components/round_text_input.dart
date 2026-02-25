import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Campo de texto com bordas arredondadas; suporta modo senha.
class RoundTextInput extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  TextEditingController controller;
  RoundTextInput(
    this.hintText, {
    super.key,
    required this.isPassword,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: controller,
        style: GoogleFonts.inter(),
        obscureText: isPassword,
        obscuringCharacter: '•',
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 158, 158, 158)),
        ),
      ),
    );
  }
}
