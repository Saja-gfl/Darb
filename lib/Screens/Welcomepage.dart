//welcome Screan
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/Screens/LoginPage.dart';

import '../routes/app_routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية الصورة
          /* Positioned.fill(
            child: Image.asset(
              'assets/images/welcome_bg.png', 
              fit: BoxFit.cover,
            ),
          ),*/
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3), // شفافية بسيطة
            ),
          ),
          // المحتوى
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                // النص "مرحبًا بك في"
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight, 
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 50), 
                    child: Text(
                      'مرحبًا بك في',
                      style: GoogleFonts.tajawal(
                        // تغيير نوع الخط باستخدام مكتبة google_fonts
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
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
                // زر "ابدأ"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context,  AppRoutes.k0Screen); 
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF9000), // لون درب البرتقالي
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'ابدأ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
