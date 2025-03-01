import 'package:flutter/material.dart';
import '../../core/app_export.dart';
<<<<<<< Updated upstream
import 'ChatPage.dart';
import 'DriverInfoPage.dart';
import 'CustomBottomNavBar.dart';
=======
import 'ChatPage';
import 'DriverInfoPage.dart';
>>>>>>> Stashed changes

class DriverHomePage extends StatefulWidget {
  DriverHomePage({Key? key}) : super(key: key);

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
<<<<<<< Updated upstream
  int _currentIndex = 0; // Track the selected index

=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatPage()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DriverInfoPage()));
          }
        },
      ),
=======
      bottomNavigationBar: _buildBottomNavBar(),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
          Text("تم استلام طلب اشتراك جديد من المستخدم خالد",
              style: theme.textTheme.bodyMedium),
          SizedBox(height: 4.h),
          Text("منذ ساعة واحدة",
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
=======
          Text("تم استلام طلب اشتراك جديد من المستخدم خالد", style: theme.textTheme.bodyMedium),
          SizedBox(height: 4.h),
          Text("منذ ساعة واحدة", style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        _buildServiceItem("عرض الاشتراكات الحالية",
            "متابعة جدول اشتراكاتك الحالية", Icons.list, () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DriverActiveSubscriptionsPage()));
        }),
        SizedBox(height: 16.h),
        _buildServiceItem(
            "طلبات اشتراك جديدة", "طلبات الاشتراك المتاحة", Icons.shopping_cart,
            () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DriverSubscriptionRequestsPage()));
=======
        _buildServiceItem("عرض الاشتراكات الحالية", "متابعة جدول اشتراكاتك الحالية", Icons.list, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DriverActiveSubscriptionsPage()));
        }),
        SizedBox(height: 16.h),
        _buildServiceItem("طلبات اشتراك جديدة", "طلبات الاشتراك المتاحة", Icons.shopping_cart, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DriverSubscriptionRequestsPage()));
>>>>>>> Stashed changes
        }),
      ],
    );
  }

<<<<<<< Updated upstream
  Widget _buildServiceItem(
      String title, String description, IconData icon, VoidCallback onTap) {
=======
  Widget _buildServiceItem(String title, String description, IconData icon, VoidCallback onTap) {
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======

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
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DriverInfoPage()));
        }
      },
    );
  }
>>>>>>> Stashed changes
}

class DriverActiveSubscriptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الاشتراكات الجارية")),
      body: Center(child: Text("محتوى صفحة الاشتراكات الجارية للسائق")),
    );
  }
}

class DriverSubscriptionRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("طلبات الاشتراك")),
      body: Center(child: Text("محتوى صفحة طلبات الاشتراك للسائق")),
    );
  }
}
