import 'package:flutter/material.dart';
import '../model/messages.dart'; // sua classe Message

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final FocusNode _focusNode;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // <-- NOVO

  final List<Message> messages = [
    Message(text: "Oi!", time: "10:00", isMe: false),
    Message(text: "E aí, tudo bem?", time: "10:01", isMe: true),
    Message(text: "Tudo sim, e você?", time: "10:02", isMe: false),
    Message(text: "Tranquilo!", time: "10:03", isMe: true),
  ];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose(); // <-- NOVO
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final now = TimeOfDay.now();
      final formattedTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

      setState(() {
        messages.add(Message(text: text, time: formattedTime, isMe: true));
      });
      _controller.clear();
      FocusScope.of(context).requestFocus(_focusNode);

      // Scroll automático para o final
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // tocar fora fecha o teclado
      child: Scaffold(
        resizeToAvoidBottomInset: true, // <-- IMPORTANTE
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
                controller: _scrollController, // <-- NOVO
                padding: const EdgeInsets.all(12),
                reverse: true, // <-- MUITO IMPORTANTE
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[messages.length - 1 - index]; // <-- Corrige a ordem
                  final alignment = message.isMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start;
                  final bgColor = message.isMe ? Colors.blue[100] : Colors.grey[300];
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
                              message.text,
                              style: TextStyle(color: textColor, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              message.time,
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
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.send,
                decoration: const InputDecoration(
                  hintText: "Digite uma mensagem...",
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blue),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
