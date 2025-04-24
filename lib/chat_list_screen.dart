import 'package:chat/auth_screen.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  // Lista de mensagens de exemplo, com um mapa contendo o nome, mensagem e hora de cada conversa.
  final List<Map<String, String>> messages = const [
    {'name': 'João', 'message': 'joinha', 'time': '10:30'},
    {'name': 'Thomas', 'message': 'lol Bora?', 'time': '09:15'},
    {'name': 'Ale', 'message': 'Oi, tudo bem?', 'time': '12:00'},
    {'name': 'Lucas', 'message': 'Vamos jogar mais tarde?', 'time': '13:45'},
    {'name': 'Ana', 'message': 'Já viu o novo filme?', 'time': '15:20'},
    {'name': 'Carlos', 'message': 'Reunião às 17h', 'time': '14:10'},
    {'name': 'Paula', 'message': 'Gostei do projeto!', 'time': '11:05'},
    {'name': 'Fernando', 'message': 'Passa o link aí', 'time': '16:50'},
    {'name': 'Juliana', 'message': 'Boa noite!', 'time': '21:30'},
    {'name': 'Bruno', 'message': 'Vamos estudar Flutter?', 'time': '08:00'},
    {'name': 'Sofia', 'message': 'Que madeira enorme a sua', 'time': '18:25'},
    {'name': 'Renato', 'message': 'To sem net', 'time': '19:55'},
    {'name': 'Clara', 'message': 'Volto mais tarde', 'time': '20:45'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0D0D1B,
      ), // Define a cor de fundo do scaffold
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D1B), // Cor do AppBar
        elevation: 0, // Retira a sombra do AppBar
        centerTitle: true, // Centraliza o título da AppBar
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), // Ícone de voltar, Poderia ser um ícone de perfil do usuário, que, ao ser clicado, levaria a uma tela onde ele poderia alterar o nome, a senha e a foto de perfil.
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthScreen(),
              ), // Navega para a tela de Login ao clicar
            );
          },
        ),
        title: const Text(
          "Lista de Mensagens",
          style: TextStyle(
            fontSize: 24,
            color: Color.fromRGBO(255, 255, 255, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.person_add,
              color: Colors.white,
            ), // Ícone de adicionar pessoa
            onPressed: () {
              final emailController = TextEditingController();

              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: const Color(0xFF1A1A2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                'Enviar mensagem',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Email do usuário',
                                  labelStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white38,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.blueAccent,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      final email = emailController.text;
                                      if (email.isNotEmpty) {
                                        // Ação ao enviar a mensagem
                                        print('Mensagem enviada para $email');
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                    ),
                                    child: const Text('Enviar mensagem'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(
            60,
          ), // Define a altura da barra inferior
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(
                  0xFF1A1A2E,
                ), // Cor de fundo do campo de pesquisa
                borderRadius: BorderRadius.circular(
                  12,
                ), // Arredonda os cantos do campo
              ),
              child: const TextField(
                style: TextStyle(
                  color: Colors.white,
                ), // Estilo do texto digitado
                cursorColor: Colors.white, // Cor do cursor
                decoration: InputDecoration(
                  hintText: 'Pesquisar contato', // Texto de sugestão
                  hintStyle: TextStyle(
                    color: Colors.white70,
                  ), // Estilo do texto de sugestão
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white70,
                  ), // Ícone de pesquisa
                  border: InputBorder.none, // Remove a borda
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14,
                  ), // Padding dentro do campo
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount:
            messages
                .length, // Quantidade de itens na lista (tamanho da lista de mensagens)
        itemBuilder: (context, index) {
          final msg = messages[index]; // Acessa o item da lista
          return Card(
            color: const Color(
              0xFF1A1A2E,
            ), // Cor do cartão de cada item da lista
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ), // Espaçamento ao redor do cartão
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ), // Arredonda os cantos do cartão
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueAccent, // Cor do avatar
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ), // Ícone do avatar, trocar por uma imagem
              ),
              title: Text(
                msg['name']!, // Nome da pessoa
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                msg['message']!, // Mensagem
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: Text(
                msg['time']!, // Hora da mensagem
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
