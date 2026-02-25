import 'package:flutter/material.dart';
import 'package:login_screen/features/shared/text_styles.dart';

import 'auth_login.dart';
import 'auth_register.dart';
import 'background.dart';
import '../../shared/helper.dart';

/// Alternador entre os modos de login e registro. Troca o formulário exibido conforme o modo ativo.
class AuthToggle extends StatefulWidget {
  final bool isLogin;
  final Function(bool) onToggle;

  const AuthToggle({super.key, required this.isLogin, required this.onToggle});

  @override
  State<AuthToggle> createState() => _AuthToggle();
}

/// Estado interno do AuthToggle que gerencia a UI conforme o modo ativo.
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

/// Tela de autenticação. Combina o header e o alternador de formulários (login/registro).
/// Gerencia seu próprio layout: mobile usa percentual de altura, desktop exibe card centralizado.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

/// Estado da AuthScreen que controla a alternância entre login e registro.
class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void onToggle(bool value) {
    setState(() {
      isLogin = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wide = ScreenHelper.isWideScreen(context);

    Widget content;

    if (!wide) {
      content = SingleChildScrollView(
        child: Column(
          children: [
            AuthHeader(child: AuthHeaderContent(isLogin: isLogin)),
            AuthFormContainer(
              color: const Color.fromARGB(255, 248, 250, 252),
              child: AuthToggle(isLogin: isLogin, onToggle: onToggle),
            ),
          ],
        ),
      );
    } else {
      content = Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AuthHeaderContent(isLogin: isLogin),
                const SizedBox(height: 32),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 248, 250, 252),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: AuthToggle(isLogin: isLogin, onToggle: onToggle),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 81, 250),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GradientContainer(
          const Color.fromARGB(255, 15, 81, 250),
          const Color.fromARGB(255, 0, 180, 238),
          child: SafeArea(
            bottom: false,
            child: content,
          ),
        ),
      ),
    );
  }
}
