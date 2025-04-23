import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/app_routes.dart';
import '../services/ChatService.dart';
import '../services/UserProvider.dart';
import 'ChatPage.dart';

class ChatHomePage extends StatefulWidget {
  final bool isDriver;

  const ChatHomePage({Key? key, this.isDriver = false}) : super(key: key);

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  final Color primaryColor = const Color(0xFFFFB300);
  final Color backgroundColor = const Color(0xFFF5F5F5);
  final TextEditingController _searchController = TextEditingController();

  // Mock chat data
  List<Map<String, dynamic>> _activeChats = [
    /*{
      'id': '2',
      'userName': 'محمد الراكب',
      'lastMessage': 'شكراً على التوصيل!',
      'time': 'أمس',
      'unread': 0,
      'isOnline': false,
      'tripId': 'trip456',
      'userId': 'user1',
    },*/
  ];
  @override
  void initState() {
    super.initState();
    _fetchActiveChats();
  }

  void _fetchActiveChats() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.uid;

    if (userId != null) {
      // Fetch active chats from the server or database
      final querySnapshot = await FirebaseFirestore.instance
          .collection('chatRooms')
          .where('driverId', isEqualTo: userId)
          //.where('status_ride', isEqualTo: 'active')
          .get();

      setState(() {
        _activeChats = querySnapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'tripId': doc.id,
            'userName': doc.id,
            'lastMessage': data['lastMessage'] ?? 'لا توجد رسائل',
            'time': ChatService.formatTimestamp(data['timestamp']),
            'unread': data['unread'] ?? 0,
          };
        }).toList();
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'المحادثات',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // تم حذف جزء البادding والبحث هنا

          // قائمة المحادثات فقط
          Expanded(
            child: ListView.builder(
              itemCount: _activeChats.length,
              itemBuilder: (context, index) {
                final chat = _activeChats[index];
                return _buildChatItem(chat);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat) {
    return InkWell(
      onTap: () async {
        await ChatService().markMessagesAsRead(chat['tripId']);
        // Navigate to chat page with the selected chat details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              tripId: chat['tripId'],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: primaryColor.withOpacity(0.2),
                  child: Icon(
                    Icons.person,
                    color: primaryColor,
                    size: 28,
                  ),
                ),
                /*if (chat['isOnline']==true)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),*/
              ],
            ),

            const SizedBox(width: 12),

            // Chat info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat['userName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      Text(
                        chat['time'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          chat['lastMessage'],
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontFamily: 'Tajawal',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (chat['unread'] > 0)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat['unread'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
