import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/core/utils/image_constant.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'package:rem_s_appliceation9/widgets/custom_image_view.dart';
import 'package:rem_s_appliceation9/Screens/OngoingSubPage.dart';
import 'package:rem_s_appliceation9/Screens/AccountPageUser.dart';
import 'package:rem_s_appliceation9/Screens/subpage.dart';
import 'package:rem_s_appliceation9/Screens/Requestedsubpage.dart';

import '../services/NotifProvider .dart';
import '../services/UserProvider.dart';
import 'MessagesHomePage.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  TextEditingController usernameInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController confirmPasswordInputController =
      TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();
  TextEditingController carTypeController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();

  String radioGroup = "";
  bool isDriver = false;
  void initNotifications() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission();
  print('🟢 User granted permission: ${settings.authorizationStatus}');

  String? token = await messaging.getToken();
  print("📲 FCM Token: $token");

  // بإمكانك حفظ التوكن في Firestore هنا تحت userData أو driverData حسب الدور
}

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

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
              _buildNotificationsSection(),
              SizedBox(height: 24.h),
              _buildServicesSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
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

/*Widget _buildNotificationsSection() {
  return Consumer<NotificationProvider>(
    builder: (context, notificationProvider, child) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("الإشعارات", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            notificationProvider.notifications.isEmpty
                ? Center(child: Text("لا يوجد إشعارات حالياً."))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: notificationProvider.notifications.length,
                    itemBuilder: (context, index) {
                      final notification =
                          notificationProvider.notifications[index];
                      return ListTile(
                        title: Text(notification['title']!),
                        subtitle: Text(notification['body']!),
                        
                      );
                    },
                  ),
          ],
        ),
      );
    },
  );
}*/
  Widget _buildNotificationsSection() {
    return Consumer<NotificationProvider>(
      builder: (context, notificationProvider, child) {
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
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("الإشعارات", style: theme.textTheme.titleLarge),
              SizedBox(height: 8.h),
              if (notificationProvider.notifications.isEmpty)
                Center(
                  child: Text(
                    "لا يوجد إشعار حاليًا.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      notificationProvider.notifications.first['title'] ?? '',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            notificationProvider.clearNotifications(); 
                          },
                          child: Text(
                            "تم",//اضافة الوقت 
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          notificationProvider.notifications.first['body'] ??
                              '',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("الخدمات", style: theme.textTheme.titleLarge),
        SizedBox(height: 16.h),
        _buildServiceItem(
          "إنشاء اشتراك جديد",
          " انشاء اشتراك ",
          Icons.add_circle_outline,
          () => _navigateToSubPage(),
        ),
        SizedBox(height: 16.h),
        _buildServiceItem(
          "عرض الاشتراكات الجارية",
          "استعراض جميع الاشتراكات  مع السائقين",
          Icons.calendar_today,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OngoingSubPage()),
          ),
        ),
        SizedBox(height: 16.h),
        _buildServiceItem(
          "إدارة طلبات الاشتراك",
          "استعراض ومعالجة طلبات الاشتراك الجديدة",
          Icons.settings,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Requestedsubpage()),
          ),
        ),
        /*SizedBox(height: 16.h),
        _buildServiceItem(
          "الانضمام إلى اشتراك",
          "عرض قائمة الاشتراكات النشطة والانضمام إليها",
          Icons.group_add,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActiveSubscriptionsPage()),
          ),
        ),*/
      ],
    );
  }

  Widget _buildServiceItem(
      String title, String description, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange, size: 24.h),
            SizedBox(width: 16.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  SizedBox(height: 4.h),
                  Text(description, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "الرسائل"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "الحساب"),
      ],
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 1) {
          final tripId =
              Provider.of<UserProvider>(context, listen: false).tripId;

          if (tripId != null && tripId != '') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessagesHomePage(
                 
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("لا توجد محادثات حالية")),
            );
          }
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountPageUser()),
          );
        }
      },
    );
  }

  void _navigateToSubPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateSubscriptionPage()));
  }
}

class ActiveSubscriptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الاشتراكات الجارية")),
      body: Center(child: Text("محتوى صفحة الاشتراكات الجارية")),
    );
    
  }
}

class SubscriptionRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("طلبات الاشتراك")),
      body: Center(child: Text("محتوى صفحة طلبات الاشتراك")),
    );
  }
}
