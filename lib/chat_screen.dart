import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {"text": "Oi!", "time": "10:00", "isMe": false},
      {"text": "E aí, tudo bem?", "time": "10:01", "isMe": true},
      {"text": "Tudo sim, e você?", "time": "10:02", "isMe": false},
      {"text": "Tranquilo!", "time": "10:03", "isMe": true},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D1B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue),
            ),
            const SizedBox(width: 12),
            const Text("Contato", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final alignment =
                    message['isMe']
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start;
                final bgColor =
                    message['isMe'] ? Colors.blue[100] : Colors.grey[300];
                final textColor = Colors.black;

                return Column(
                  crossAxisAlignment: alignment,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      constraints: const BoxConstraints(maxWidth: 250),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message['text'],
                            style: TextStyle(color: textColor, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            message['time'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Digite uma mensagem...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      // ação de envio
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
