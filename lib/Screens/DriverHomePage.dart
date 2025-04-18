import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/image_constant.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'package:rem_s_appliceation9/widgets/custom_image_view.dart';
import 'package:rem_s_appliceation9/Screens/MessagesHomePage.dart';
import 'package:rem_s_appliceation9/Screens/DriverOngoingSubPage.dart';
import 'package:rem_s_appliceation9/Screens/AvailableSubscriptionsPage.dart';
import 'DriverInfoPage.dart';
import 'CustomBottomNavBar.dart';
import 'DriverOngoingSubsPage.dart';
import 'DriverSubscriptionsPage.dart';
// كومنت مهم تحت !! 
import 'package:provider/provider.dart';
import '../services/UserProvider.dart';

// كومنت مهم تحت !!
import 'package:rem_s_appliceation9/Screens/AccountPage.dart';
import 'package:rem_s_appliceation9/Screens/CustomBottomNavBar.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int _currentIndex = 0;

  // Mock data for chat parameters
  final String mockTripId = 'trip_123456';
  final String mockUserId = 'driver_789';
  final String mockUserName = 'السائق أحمد';

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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
             
          if (index == 1) {
            //final userProvider = Provider.of<UserProvider>(context, listen: false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                ),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DriverInfoPage()),
            );
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MessagesHomePage()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DriverInfoPage()));
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
          Text("تم استلام طلب اشتراك جديد من المستخدم خالد",
              style: theme.textTheme.bodyMedium),
          SizedBox(height: 4.h),
          Text("منذ ساعة واحدة",
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    //final userProvider = Provider.of<UserProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("الخدمات", style: theme.textTheme.titleLarge),
        SizedBox(height: 16.h),
        _buildServiceItem(
          "عرض الاشتراكات الحالية",
          "متابعة جدول اشتراكاتك الحالية",
          Icons.list,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  // builder: (context) => AvailableSubscriptionsPage()));
                  //اللي فاضيه تنقل الدوال من الصفحة المؤقته الي تحت الكومنت الى الصفحة اللي سوته مرام فوق الكومنت هذا
                  builder: (context) => DriverSubscriptionsPage()));
        }),
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
}
