import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/Screens/chatPage.dart';

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
  final List<Map<String, dynamic>> _allChats = [
    {
      'id': '1',
      'userName': 'أحمد السائق',
      'lastMessage': 'سأكون هناك خلال 10 دقائق',
      'time': '10:30 ص',
      'unread': 2,
      'isOnline': true,
      'tripId': 'trip123',
      'userId': 'driver1',
    },
    {
      'id': '2',
      'userName': 'محمد الراكب',
      'lastMessage': 'شكراً على التوصيل!',
      'time': 'أمس',
      'unread': 0,
      'isOnline': false,
      'tripId': 'trip456',
      'userId': 'user1',
    },
    {
      'id': '3',
      'userName': 'سارة',
      'lastMessage': 'أين نقطة اللقاء؟',
      'time': 'الثلاثاء',
      'unread': 1,
      'isOnline': true,
      'tripId': 'trip789',
      'userId': 'user2',
    },
  ];

  @override
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
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ابحث عن محادثة...',
                  hintStyle: const TextStyle(fontFamily: 'Tajawal'),
                  prefixIcon: Icon(Icons.search, color: primaryColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),

          // Chat List
          Expanded(
            child: ListView.builder(
              itemCount: _allChats.length,
              itemBuilder: (context, index) {
                final chat = _allChats[index];
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              tripId: chat['tripId'],
              userId: widget.isDriver ? 'driver1' : chat['userId'],
              userName: widget.isDriver ? 'السائق' : chat['userName'],
              isDriver: widget.isDriver,
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
                if (chat['isOnline'])
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
                  ),
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
