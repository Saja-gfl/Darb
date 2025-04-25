import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/Screens/DriverHomePage.dart';

import '../services/UserProvider.dart';
import 'DriverInfoPage.dart';
import 'MessagesHomePage.dart';
import 'chatPageLDriver.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentIndex = 2; // Highlight account tab
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!_isDataLoaded) {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        Provider.of<UserProvider>(context, listen: false).loadUserData(userId);
      }
      _isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    String name = userProvider.userName ?? 'غير متوفر';
    String email = userProvider.email ?? "غير متوفر ";
    String gender = userProvider.Gender ?? "غير محدد";
    String phone = userProvider.phoneNumber ?? "غير متوفر ";
    String address = userProvider.location ?? "غير متوفر ";
    String catType = userProvider.carType ?? "غير معروف";
    String plateNumber = userProvider.plateNumber ?? "غير معروف";
    String sub = userProvider.subscriptionType ?? "غير محدد";
    String acceptedLocations = userProvider.acceptedLocations ?? "غير محدد";
    String passengerCount = userProvider.passengerCount ?? "غير محدد";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "حسابي",
          style: GoogleFonts.getFont(
            'Inter',
            color: const Color(0xFFFFB300),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Profile Section
            _buildProfileSection(name, email),
            const SizedBox(height: 24),

            // User Info Section
            _buildInfoCard(
              title: "معلوماتي",
              items: [
                _buildInfoItem("الاسم", name),
                _buildInfoItem("البريد الإلكتروني", email),
                _buildInfoItem("الجنس", gender),
                _buildInfoItem("نوع السيارة", catType),
                _buildInfoItem("رقم اللوحة", plateNumber),
                _buildInfoItem("نوع الاشتراك", sub),
                _buildInfoItem("عدد الركاب", passengerCount),
                _buildInfoItem("المواقع المقبولة", acceptedLocations),
              ],
            ),
            const SizedBox(height: 16),

            // Contact Section
            _buildInfoCard(
              title: "معلومات الاتصال",
              items: [
                _buildInfoItem("رقم الجوال", phone),
                _buildInfoItem("العنوان", address),
              ],
            ),
            const SizedBox(height: 16),

            // Actions Section
            _buildActionButtons(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFFF9800),
        unselectedItemColor: Colors.grey,
        items: const [
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
            label: "حسابي",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DriverHomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MessagesHomePage()),
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

  Widget _buildProfileSection(String name, String email) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFFEEEEEE),
            child: Icon(
              Icons.person,
              size: 50,
              color: Color(0xFF9E9E9E),
            ),
          ),
          SizedBox(height: 16),
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            email,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<Widget> items}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFB300),
              ),
            ),
            const SizedBox(height: 12),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.edit, color: Color(0xFFFFB300)),
          title: const Text(
            "تعديل الملف الشخصي",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black87),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DriverInfoPage()),
            );
          },
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text(
            "تسجيل الخروج",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.red),
          ),
          onTap: () async {
            await FirebaseAuth.instance.signOut();

            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.clearUserData();

            //اخبار المستخدم تم تسجيل الخروج بنجاح
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("تم تسجيل الخروج بنجاح"),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pushReplacementNamed(context, '/login_page');
          },
        ),
      ],
    );
  }
}
