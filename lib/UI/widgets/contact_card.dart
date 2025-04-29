import 'package:flutter/material.dart';
import 'package:chat/UI/chat_screen.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String message;
  final String time;

  const ContactCard({
    super.key,
    required this.name,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1A2E),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          message,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: Text(
          time,
          style: const TextStyle(color: Colors.white60, fontSize: 12),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        },
      ),
    );
  }
}
