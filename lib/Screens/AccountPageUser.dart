import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rem_s_appliceation9/Screens/DriverHomePage.dart';
import 'package:rem_s_appliceation9/Screens/MessagesHomePage.dart';
import 'package:rem_s_appliceation9/Screens/UserProfilePage.dart';
import 'package:rem_s_appliceation9/Screens/SettingsPage.dart';
import 'package:rem_s_appliceation9/services/UserProvider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentIndex = 2; // Highlight account tab
  String name = "أحمد محمد";
  String email = "ahmed@example.com";
  String gender = "ذكر";
  String phone = "0551234567";
  String address = "الرياض، المملكة العربية السعودية";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('userdata')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          setState(() {
            name = userData['name'] ?? name;
            email = userData['email'] ?? email;
            gender = userData['gender'] ?? gender;
            phone = userData['phone'] ?? phone;
            address = userData['address'] ?? address;
          });
        }
      } catch (e) {
        print("Error loading user data: $e");
      }
    }
  }

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
                _buildInfoItem("الاسم", name),
                _buildInfoItem("البريد الإلكتروني", email),
                _buildInfoItem("الجنس", gender),
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

  Widget _buildProfileSection() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: const Color(0xFFEEEEEE),
            child: Icon(
              Icons.person,
              size: 50,
              color: const Color(0xFF9E9E9E),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            email,
            style: const TextStyle(
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
            ).then(
                (_) => _loadUserData()); // Reload data when returning from edit
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
