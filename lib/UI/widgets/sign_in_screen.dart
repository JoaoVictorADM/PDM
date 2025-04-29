import 'package:flutter/material.dart';
import 'password_field.dart';
import '../chat_list_screen.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onToggleForm;

  const SignInScreen({super.key, required this.onToggleForm});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChatListScreen()),
      );
    }
  }

  void _showForgotPasswordDialog(BuildContext context) {
    final _forgotFormKey = GlobalKey<FormState>();
    final TextEditingController _forgotEmailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Recuperar Senha"),
          content: SizedBox(
            width: 300,
            child: Form(
              key: _forgotFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Informe seu e-mail para receber o código:",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _forgotEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "E-mail",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O e-mail é obrigatório';
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Digite um e-mail válido';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_forgotFormKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  _showCodeAndPasswordDialog(context);
                }
              },
              child: const Text("Enviar Código"),
            ),
          ],
        );
      },
    );
  }

  void _showCodeAndPasswordDialog(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _codeController = TextEditingController();
    final TextEditingController _newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Redefinir Senha"),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.code),
                        hintText: "Insira o código",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite o código';
                        }
                        if (value != '0000') {
                          return 'Código incorreto!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      hintText: "Nova Senha",
                      controller: _newPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite a nova senha';
                        }
                        if (value.length < 6) {
                          return 'Senha deve ter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Senha alterada com sucesso!")),
                  );
                  Navigator.of(context).pop(); // Fecha o pop-up
                }
              },
              child: const Text("Confirmar"),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.security, size: 50, color: Colors.white),
          const SizedBox(height: 15),
          const Text(
            'Entre em sua\nConta',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Não tem uma conta? ",
                style: TextStyle(color: Colors.white70),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: widget.onToggleForm,
                child: const Text(
                  "Cadastre-se",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O email é obrigatório';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Digite um email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                PasswordField(
                  hintText: "Senha",
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A senha é obrigatória';
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {
                    _showForgotPasswordDialog(context);
                  },
                  child: const Text(
                    "Esqueceu sua senha?",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _submit,
                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
