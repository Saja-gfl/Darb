import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/Screens/DriverHomePage.dart';
import 'package:rem_s_appliceation9/Screens/MessagesHomePage.dart';
import 'package:rem_s_appliceation9/Screens/UserProfilePage.dart';
import 'package:rem_s_appliceation9/Screens/SettingsPage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentIndex = 2; // Highlight account tab

  @override
  Widget build(BuildContext context) {
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
            _buildProfileSection(),
            const SizedBox(height: 24),

            // User Info Section
            _buildInfoCard(
              title: "معلوماتي",
              items: [
                _buildInfoItem("الاسم", "أحمد محمد"),
                _buildInfoItem("البريد الإلكتروني", "ahmed@example.com"),
                _buildInfoItem("الجنس", "ذكر"),
              ],
            ),
            const SizedBox(height: 16),

            // Contact Section
            _buildInfoCard(
              title: "معلومات الاتصال",
              items: [
                _buildInfoItem("رقم الجوال", "0551234567"),
                _buildInfoItem("العنوان", "الرياض، المملكة العربية السعودية"),
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

  Widget _buildProfileSection() {
    return const Center(
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
            "أحمد محمد",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "ahmed@example.com",
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
              MaterialPageRoute(builder: (context) => const UserProfilePage()),
            );
          },
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.settings, color: Color(0xFFFFB300)),
          title: const Text(
            "الإعدادات",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black87),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
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
          onTap: () {
            // Handle logout
          },
        ),
      ],
    );
  }
}
