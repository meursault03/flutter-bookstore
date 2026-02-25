import 'package:flutter/material.dart';
import 'package:login_screen/features/shared/text_styles.dart';
import 'package:login_screen/services/session_manager.dart';

import '../../homepage/components/home_background.dart';
import '../../shared/custom_buttons.dart';
import 'round_text_input.dart';

/// Formulário de cadastro com campos: nome, sobrenome, email, senha e confirmação.
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterForm();
}

/// Estado do RegisterForm com controle de todos os campos e validação de senha.
class _RegisterForm extends State<RegisterForm> {
  TextEditingController forenameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    forenameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 3),
                    child: StyleTextUnaligned(
                      'Nome',
                      13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  RoundTextInput(
                    'João',
                    isPassword: false,
                    controller: forenameController,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 3),
                    child: StyleTextUnaligned(
                      'Sobrenome',
                      13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  RoundTextInput(
                    'da Silva',
                    isPassword: false,
                    controller: surnameController,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 3),
          child: StyleTextUnaligned(
            'Email',
            13,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        RoundTextInput(
          'example@dominio.com',
          isPassword: false,
          controller: emailController,
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 3),
          child: StyleTextUnaligned(
            'Senha',
            13,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        RoundTextInput(
          '•••••••••••',
          isPassword: true,
          controller: passwordController,
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 3),
          child: StyleTextUnaligned(
            'Confirmar senha',
            13,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        RoundTextInput(
          '•••••••••••',
          isPassword: true,
          controller: confirmPasswordController,
        ),
        const SizedBox(height: 24),
        RoundButton(
          'Registrar',
          onPressed: () async {
            // Check for empty fields
            if (forenameController.text.isEmpty ||
                surnameController.text.isEmpty ||
                emailController.text.isEmpty ||
                passwordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Preencha todos os campos.')),
              );
              return;
            }
            if (passwordController.text != confirmPasswordController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('As senhas não coincidem.')),
              );
              return;
            }
            await SessionManager().saveSession(
              forenameController.text,
              surnameController.text,
              emailController.text,
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registro realizado com sucesso!'),
                ),
              );

              // Adicione a instrução de navegação
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          },
        ),
      ],
    );
  }
}
