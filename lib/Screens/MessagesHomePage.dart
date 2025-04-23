import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/core/utils/image_constant.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'package:rem_s_appliceation9/widgets/custom_image_view.dart';
import 'package:rem_s_appliceation9/Screens/ChatPage.dart';
import 'package:rem_s_appliceation9/Screens/DriverHomePage.dart';
import 'package:rem_s_appliceation9/Screens/AccountPage.dart';

import '../services/ChatService.dart';
import '../services/UserProvider.dart';
import '../services/request.dart';

class MessagesHomePage extends StatefulWidget {
  const MessagesHomePage({Key? key}) : super(key: key);

  @override
  _MessagesHomePageState createState() => _MessagesHomePageState();
}

class _MessagesHomePageState extends State<MessagesHomePage> {
  final ChatService _chatService = ChatService();
  List<Map<String, dynamic>> _activeChats = [];
  int _currentIndex = 1; // Highlight messages tab

  @override
  void initState() {
    super.initState();
    _fetchActiveChats();
  }

  void _fetchActiveChats() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.uid;

    if (userId != null) {
      try {
        // Fetch active chats from the server or database
        final querySnapshot = await FirebaseFirestore.instance
            .collection('chatRooms')
            .where('driverId', isEqualTo: userId)
            //.where('status_ride', isEqualTo: 'active')
            .get();

        setState(() {
          _activeChats = querySnapshot.docs.map((doc) {
            final data = doc.data();
            print("Data fetched: $data");
            
            return {
              'tripId': doc.id ?? 'no tripId',
              'userName': doc.id + ': رحلة رقم',
              'lastMessage': data['lastMessage']  ?? 'لا توجد رسائل',
              'time': data['timestamp'] is Timestamp
                  ? ChatService.formatTimestamp(data['timestamp'])
                  : 'مافيه وقت', // تحقق من النوع
              'unread': data['unread'] ?? 0,
            };
          }).toList();
        });
      } catch (e) {
        print("❌ خطأ أثناء جلب المحادثات: $e");
        // Handle error if needed
      }
    }
  }
  //قائم دردشات اليوزر بس خلاص غيرناه
  /*
  void _fetchUserChats() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.uid;

    if (userId != null) {
      final chats = await _chatService.getUserChatRooms(userId);
      setState(() {
        _userChats = chats.map((chat) {
          check_Sub_tatus(chat['tripId'], userId);
          return {
            'name': ((chat['name'] ?? 'غير معروف') +
                ": رحلة رقم"), // قيمة افتراضية للاسم
            'lastMessage':
                chat['lastMessage'] ?? 'لا توجد رسائل', // قيمة افتراضية للرسالة
            'time':ChatService.formatTimestamp(chat['timestamp']), // قيمة افتراضية للوقت
            'unread': chat['unread'] ?? 0, // قيمة افتراضية لحالة القراءة
            'tripId': chat['tripId'] ?? '', // تأكد من وجود tripId
          };
        }).toList();
      });
    }
  }*/

  @override

  // Mock chat data احذفوه
  final List<Map<String, dynamic>> _chats = [];
  /*{
      'id': 'user_1',
      'name': 'RR249153' + ':رحلة رقم',
      'lastMessage': 'When will you arrive today?',
      'time': '10:30 ص',
      'unread': 1,
      'isDriver': false,
      'tripId': 'R209658'
    },
    {
      'id': 'user_2',
      'name': 'R393497' + ':رحلة رقم',
      'lastMessage': 'thank you for the ride!',
      'time': 'أمس',
      'unread': 1,
      'isDriver': false,
      'tripId': 'R209658'
    },
  
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildLogo(),
              SizedBox(height: 24.h),
              _buildHeaderSection(),
              SizedBox(height: 24.h),
              _buildChatsList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFFF9800),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "المحادثات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "الحساب",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DriverHomePage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AccountPage()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }

  Widget _buildLogo() {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomImageView(
        height: 56.h,
        width: 116.h,
        imagePath: ImageConstant.img5935976241859510486,
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.h,
            offset: Offset(0, 2.h),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("المحادثات",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: const Color(0xFFFF9800),

                    // Orange color from theme
                  )),
              SizedBox(height: 4.h),
              Text(
                "${_activeChats.where((chat) => chat['unread'] > 0).length} رسائل جديدة",
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("المحادثات النشطة",
            style: theme.textTheme.titleLarge?.copyWith(
              color: const Color(0xFFFF9800), // Orange color from theme
            )),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _activeChats.length, // استخدام البيانات الوهمية
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final chat = _activeChats[index];
            return _buildChatItem
              (chat);      },
      ),
    ],
  );
}
      
  Widget _buildChatItem(Map<String, dynamic> chat) {
    return InkWell(
      onTap: () async {
        await _chatService.markMessagesAsRead(chat['tripId']);
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
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.h),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.h,
              offset: Offset(0, 2.h),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(chat['time'] ?? 'لايوجد وقت',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            fontSize: 12.fSize,
                          )),
                      SizedBox(width: 8.h),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(chat['userName'] ?? 'غير معروف',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: const Color.fromARGB(
                              255, 255, 189, 91), // Orange color
                          fontWeight: FontWeight.bold,
                        ))
                  ]),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (chat['unread']> 0)
                        Container(
                           padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.orange,
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
                      Expanded(
                        child: Text(
                          chat['lastMessage'] ?? 'لا توجد رسائل',
                          textAlign: TextAlign.end,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: chat['unread'] > 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.h),
            CircleAvatar(
              radius: 24.h,
              backgroundColor: Colors.orange.withOpacity(0.2),
              child: Icon(
                Icons.person,
                color: Colors.orange,
                size: 24.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
