import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/UserProvider.dart';
import 'LoginPage.dart';
import 'DriverHomePage.dart';
import 'userhome_pageM.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // تأخير بسيط لمحاكاة شاشة سبلاش
    await Future.delayed(const Duration(seconds: 2));

    final user = FirebaseAuth.instance.currentUser;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (user != null) {
      // إذا كان هناك مستخدم مسجل الدخول
      await userProvider.loadUserData(user.uid); // تحميل بيانات المستخدم

      if (userProvider.isDriver) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DriverHomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserHomePage()),
        );
      }
    } else {
      // إذا لم يكن هناك مستخدم مسجل الدخول
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => K0Screen()), // شاشة تسجيل الدخول
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3), // شفافية بسيطة
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text(
                      'مرحبًا بك في',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Image.asset(
                      'assets/images/img_5935976241859510486.png', // شعار درب
                      height: 100,
                    ),
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
