import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen/features/login/components/text_styles.dart';
import 'package:login_screen/services/session_manager.dart';

import 'background.dart';
import 'custom_buttons.dart';

/// Campo de texto com bordas arredondadas.
/// Componente reutilizável para inputs. Suporta modo senha.
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
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

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
                // TODO: tela de forgot password
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
            final Map session = await SessionManager().getSession();
            if (context.mounted) {
              if (session['email'] == emailController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login realizado com sucesso!')),
                );
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

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterForm();
}

/// Formulário de registro com campos: nome, sobrenome, email, senha e confirmação.
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
            }
          },
        ),
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
