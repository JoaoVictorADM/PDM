import 'package:chat/auth_screen.dart';
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
                // ação para trocar a senha
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
