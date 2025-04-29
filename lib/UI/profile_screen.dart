import 'package:chat/UI/auth_screen.dart';
import 'package:chat/UI/widgets/password_field.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(
    text: "João da Silva",
  );

  void _showResetPasswordDialog() {
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
                key: _formKey, // <- adiciona o formulário aqui
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Perfil",
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFF0D0D1B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: const [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 60, color: Colors.blue),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 4, bottom: 4),
                    child: Icon(Icons.camera_alt, color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Campo editável para nome
            TextField(
              controller: _nameController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            ),
            const SizedBox(height: 16),

            // E-mail fixo
            const Center(
              child: Text(
                "joao@email.com",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),
            

            // Botão de trocar senha
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Trocar Senha"),
                    content: const Text(
                      "Enviaremos um código para seu e-mail. Deseja continuar?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Cancelar"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // fecha o primeiro diálogo
                          _showResetPasswordDialog();  // abre o segundo
                        },
                        child: const Text("Enviar código"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.lock),
              label: const Text("Trocar senha"),
            ),
            const SizedBox(height: 16),
          
            // Botão de logout
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AuthScreen()),(route) => false,);
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "Sair",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
