import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'package:rem_s_appliceation9/Screens/DriverHomePage.dart';
import 'package:rem_s_appliceation9/Screens/MessagesHomePage.dart';
import 'package:rem_s_appliceation9/Screens/AccountPage.dart';
import 'package:rem_s_appliceation9/Screens/sttingsPages/HelpPage.dart';
import 'package:rem_s_appliceation9/Screens/sttingsPages/PrivacyPolicyPage.dart';
import 'package:rem_s_appliceation9/Screens/sttingsPages/TermsPage.dart';
import 'package:rem_s_appliceation9/Screens/sttingsPages/ChangePasswordPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _currentIndex = 2;
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("الإعدادات",
            style: TextStyle(
              color: Color(0xFFFFB300),
              fontSize: 24.h,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Account Settings
            _buildSectionHeader("إعدادات الحساب"),
            _buildSettingsCard([
              _buildSettingsItem(
                icon: Icons.person_outline,
                title: "تعديل الملف الشخصي",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                ),
              ),
              _buildDivider(),
              _buildSettingsItem(
                icon: Icons.lock_outline,
                title: "تغيير كلمة المرور",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                ),
              ),
            ]),
            SizedBox(height: 24.h),

            // App Settings
            _buildSectionHeader("إعدادات التطبيق"),
            _buildSettingsCard([
              _buildSwitchItem(
                icon: Icons.notifications_none,
                title: "الإشعارات",
                value: _notificationsEnabled,
                onChanged: (value) =>
                    setState(() => _notificationsEnabled = value),
              ),
              _buildDivider(),
            ]),
            SizedBox(height: 24.h),

            // Support Section
            _buildSectionHeader("الدعم"),
            _buildSettingsCard([
              _buildSettingsItem(
                icon: Icons.help_outline,
                title: "المساعدة",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPage()),
                ),
              ),
              _buildDivider(),
              _buildSettingsItem(
                icon: Icons.privacy_tip_outlined,
                title: "سياسة الخصوصية",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                ),
              ),
              _buildDivider(),
              _buildSettingsItem(
                icon: Icons.description_outlined,
                title: "شروط الخدمة",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermsPage()),
                ),
              ),
            ]),
            SizedBox(height: 24.h),

            // Logout Button
            Center(
              child: ElevatedButton(
                onPressed: _showLogoutDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.h, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                ),
                child: Text(
                  "تسجيل الخروج",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: theme.colorScheme.primary,
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
            label: "حسابي",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DriverHomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MessagesHomePage()),
            );
          } else {
            setState(() => _currentIndex = index);
          }
        },
      ),
    );
  }

  // Helper Widgets
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontSize: 18.h,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 16.h),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16.h),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 16.h),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 16.h,
      endIndent: 16.h,
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("تسجيل الخروج"),
        content: Text("هل أنت متأكد أنك تريد تسجيل الخروج؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              // Implement actual logout logic here
              // Typically: FirebaseAuth.instance.signOut()
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacementNamed(context, '/login'); // Go to login
            },
            child: Text("تسجيل الخروج", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
