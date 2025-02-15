import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Mock user (replace with your own user data)
  final types.User _user = const types.User(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
  );

  // List of messages (replace with your own message data)
  final List<types.Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: (types.PartialText message) {
          // Handle sending a message
          final types.TextMessage textMessage = types.TextMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            author: _user,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            text: message.text,
          );

          // Add the new message to the list
          setState(() {
            _messages.insert(0, textMessage);
          });
        },
        user: _user,
      ),
    );
  }
}