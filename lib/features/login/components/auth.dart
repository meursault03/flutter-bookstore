import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen/features/login/components/text_styles.dart';

import 'background.dart';
import 'custom_buttons.dart';

/// Campo de texto com bordas arredondadas.
/// Componente reutilizável para inputs. Suporta modo senha.
class RoundTextInput extends StatelessWidget {
  final String hintText;
  final bool isPassword;

  const RoundTextInput(this.hintText, {super.key, required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
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

class AuthToggle extends StatefulWidget {
  final bool isLogin;
  final Function(bool) onToggle;

  const AuthToggle({super.key, required this.isLogin, required this.onToggle});

  @override
  State<AuthToggle> createState() => _AuthToggle();
}

class _AuthToggle extends State<AuthToggle> {
  @override
  Widget build(BuildContext context) {
    Color loginBg;
    Color loginText;
    Color registerBg;
    Color registerText;
    Widget currentForm;

    bool isLogin = widget.isLogin;
    Function onToggle = widget.onToggle;

    if (widget.isLogin) {
      loginBg = Colors.white;
      loginText = Colors.blue;
      registerBg = Colors.transparent;
      registerText = Colors.grey;
      currentForm = const LoginForm();
    } else {
      loginBg = Colors.transparent;
      loginText = Colors.grey;
      registerBg = Colors.white;
      registerText = Colors.blue;
      currentForm = const RegisterForm();
    }

    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: loginBg,
                    foregroundColor: loginText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    widget.onToggle(true);
                  },
                  child: const Text('Login'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: registerBg,
                    foregroundColor: registerText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    widget.onToggle(false);
                  },
                  child: const Text('Registrar'),
                ),
              ),
            ],
          ),
        ),
        currentForm,
      ],
    );
  }
}

/// Formulário de login com campos: email e senha.
class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

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
        const RoundTextInput('example@dominio.com', isPassword: false),
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
        const RoundTextInput('•••••••••••', isPassword: true),
        const SizedBox(height: 24),
        RoundButton('Login', onPressed: () {}),
      ],
    );
  }
}

/// Formulário de registro com campos: nome, sobrenome, email, senha e confirmação.
class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Row(
          children: [
            Expanded(
              flex: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 3),
                    child: StyleTextUnaligned(
                      'Nome',
                      13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  RoundTextInput('João', isPassword: false),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              flex: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 3),
                    child: StyleTextUnaligned(
                      'Sobrenome',
                      13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  RoundTextInput('da Silva', isPassword: false),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 3),
          child: StyleTextUnaligned(
            "Email",
            13,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        const RoundTextInput('example@dominio.com', isPassword: false),
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
        const RoundTextInput('•••••••••••', isPassword: true),
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
        const RoundTextInput('•••••••••••', isPassword: true),
        const SizedBox(height: 24),
        RoundButton('Registrar', onPressed: () {}),
      ],
    );
  }
}

/// Conteudo pro header das telas de login/signup/reset.
class AuthHeaderContent extends StatelessWidget {
  final bool isLogin;
  const AuthHeaderContent({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StyleText(
          isLogin
              ? 'É bom ter você de volta, logue-se para continuar.'
              : 'Crie uma conta para começar com a gente.',
          26,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 10),
        const StyleText(
          'Nossas ofertas especiais estão esperando por você.',
          17,
          color: Colors.white70,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void onToggle(bool value) {
    setState(() {
      isLogin = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthHeader(child: AuthHeaderContent(isLogin: isLogin)),
        AuthFormContainer(
          color: const Color.fromARGB(255, 248, 250, 252),
          child: AuthToggle(isLogin: isLogin, onToggle: onToggle),
        ),
      ],
    );
  }
}
