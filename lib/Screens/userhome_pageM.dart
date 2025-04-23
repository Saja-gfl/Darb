import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/Screens/ChatPage.dart';
import 'package:rem_s_appliceation9/core/utils/image_constant.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'package:rem_s_appliceation9/widgets/CustomBottomNavBar.dart';
import 'package:rem_s_appliceation9/widgets/custom_image_view.dart';
import 'package:rem_s_appliceation9/Screens/OngoingSubPage.dart';

import 'package:rem_s_appliceation9/Screens/AccountPageUser.dart';
import 'package:rem_s_appliceation9/Screens/subpage.dart'; // Import for SubPage
import 'package:rem_s_appliceation9/Screens/Requestedsubpage.dart';

import '../services/UserProvider.dart';
import 'MessagesHomePage.dart';

// ignore_for_file: must_be_immutable
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

  Widget _buildNotificationsSection() {
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
          Text("تم قبول طلب اشتراكك من قبل السائق أحمد",
              style: theme.textTheme.bodyMedium),
          SizedBox(height: 4.h),
          Text("منذ ساعتين",
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("الخدمات", style: theme.textTheme.titleLarge),
        SizedBox(height: 16.h),
        // New subscription creation service
        _buildServiceItem(
          "إنشاء اشتراك جديد",
          " مع السائق المفضل",
          Icons.add_circle_outline,
          () => _navigateToSubPage(),
        ),
        SizedBox(height: 16.h),
        _buildServiceItem(
          "عرض الاشتراكات الجارية",
          "استعراض جميع الاشتراكات الجارية مع السائقين",
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
      ],
    );
  }

  void _navigateToSubPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateSubscriptionPage(
            // Add any required parameters here
            // For example:
            // userId: '123',
            // isNewSubscription: true,
            ),
      ),
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
         final tripId = Provider.of<UserProvider>(context, listen: false).tripId;
         //set tripId on prov

         print("trip is" + tripId!);
          if (tripId != null || tripId !='') {  
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>ChatPage(tripId: tripId), // Pass the tripId to ChatPage
              ));
          /* Navigator.push(
             context, MaterialPageRoute(builder: (context) => ChatPage( )));*/
          } else {
            // Handle the case when tripId is null
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("لا توجد محادثات حالية"),
              ),
            );
          }
        } else if (index == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AccountPageUser()));
        }
      },
    );
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
