import 'package:flutter/material.dart';
import 'package:login_screen/features/shared/text_styles.dart';
import 'package:login_screen/services/session_manager.dart';

import '../../homepage/components/home_background.dart';
import '../../shared/custom_buttons.dart';
import 'round_text_input.dart';

/// Formulário de login com campos: email e senha.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

/// Estado do LoginForm com controle de campos, visibilidade de senha e "lembrar-me".
class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  void _loadRememberMe() {
    final remembered = SessionManager().getRememberMe();
    if (remembered) {
      final session = SessionManager().getSession();
      setState(() {
        _rememberMe = true;
        emailController.text = session['email'] ?? '';
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
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
        SizedBox(
          child: TextField(
            controller: passwordController,
            obscureText: _obscurePassword,
            obscuringCharacter: '•',
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: '•••••••••••',
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 158, 158, 158),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                StyleTextUnaligned(
                  'Lembrar de mim',
                  13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Funcionalidade em desenvolvimento'),
                  ),
                );
              },
              child: const StyleTextUnaligned(
                'Esqueceu a senha?',
                13,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        RoundButton(
          'Login',
          onPressed: () async {
            if (emailController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Digite seu email.')),
              );
              return;
            }
            final Map session = SessionManager().getSession();
            if (context.mounted) {
              if (session['email'] == emailController.text) {
                await SessionManager().setRememberMe(_rememberMe);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login realizado com sucesso!'),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email incorreto.')),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
