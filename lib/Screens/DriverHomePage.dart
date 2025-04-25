import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/core/utils/image_constant.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'package:rem_s_appliceation9/widgets/custom_image_view.dart';
import '../services/NotifProvider .dart';
import 'AccountPage.dart';
import 'CustomBottomNavBar.dart';
import 'DriverSubscriptionsPage.dart';
import 'AvailableSubscriptionsPage.dart';
// كومنت مهم تحت !!

import 'package:rem_s_appliceation9/Screens/DriverOngoingSubPage.dart';
import 'package:rem_s_appliceation9/Screens/chatPageLDriver.dart';
import 'package:rem_s_appliceation9/Screens/MessagesHomePage.dart';

// كومنت مهم تحت !!

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
                builder: (context) => MessagesHomePage(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountPage()),
            );
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
                            "تم", //اضافة الوقت
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
          "عرض الاشتراكات الحالية",
          "متابعة جدول اشتراكاتك الحالية",
          Icons.list,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DriverOngoingSubPage(),
              ),
            );
          },
        ),
        SizedBox(height: 8.h), // Add some spacing between items
        _buildServiceItem(
          "طلبات الاشتراك الجديدة ",
          "عرض طلبات الاشتراكات الجديدة",
          Icons.directions_car,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AvailableSubscriptionsPage(),
              ),
            );
          },
        ),
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
