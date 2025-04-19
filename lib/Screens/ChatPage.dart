import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rem_s_appliceation9/Screens/userhome_pageM.dart';
import 'package:rem_s_appliceation9/routes/app_routes.dart';

import '../services/UserProvider.dart';
import '../services/chatService.dart';
//import 'driverHomePage.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _listenToMessages();
  }

  void _listenToMessages() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final tripId = userProvider.tripId ?? '';

    _chatService.getMessages(tripId).listen((snapshot) {
      final messages = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'senderId': data['senderId'] ?? 'unknown',
          'senderName': data['senderName'] ?? 'غير معروف',
          'message': data['message'] ?? '',
          'timestamp': data['timestamp'] ?? Timestamp.now(),
        };
      }).toList();

      setState(() {
        _messages = messages;
      });

      // Scroll to the bottom
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  void _sendMessage() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final tripId = userProvider.tripId ?? '';
    final userId = userProvider.uid ?? '';
    final userName = userProvider.userName ?? '';

    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      // استخدام ChatService لإرسال الرسالة
      _chatService.sendMessage(
        chatId: tripId, // ID غرفة الدردشة
        senderId: userId, // ID المرسل
        senderName: userName, // اسم المرسل
        message: messageText, // نص الرسالة
      );
      _messageController.clear(); // مسح حقل الإدخال بعد الإرسال
    }
  }
//حق الوقت
  /*String _formatTimestamp(Timestamp timestamp) {
  final time = timestamp.toDate();
  final hour = time.hour > 12 ? time.hour - 12 : time.hour;
  final period = time.hour >= 12 ? 'م' : 'ص';
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute $period';
}*/

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFB85C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (userProvider.isDriver) {
              Navigator.pushReplacementNamed(context, AppRoutes.driverHomePage);
              
            } else {
              Navigator.pushReplacementNamed(context, AppRoutes.userHomePage);
              
            }
          },
        ),
        title: const Text(
          'الدردشة الجماعية',
          style: TextStyle(
            fontFamily: 'Tajawal',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isCurrentUser = message['senderId'] == userProvider.uid;

                return Align(
                  alignment: isCurrentUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isCurrentUser
                          ? const Color(0xFFFFD699)
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: Radius.circular(isCurrentUser ? 12 : 0),
                        bottomRight: Radius.circular(isCurrentUser ? 0 : 12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['senderName'],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message['message'],
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك...',
                      hintStyle: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Colors.grey[600],
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFFF3E0),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFB85C),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // استدعاء دالة إرسال الرسالة
                      _sendMessage();
                    },
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
