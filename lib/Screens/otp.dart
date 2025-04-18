import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routes/app_routes.dart';
import '../services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/utils/show_toast.dart';

class OTPVerificationScreen extends StatelessWidget {
  final String verificationId;
  final String phoneNumber;
  final FirebaseAuthServises _auth = FirebaseAuthServises();
  final TextEditingController otpController = TextEditingController();

  OTPVerificationScreen(
      {required this.verificationId, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/img_5935976241859510486.png",
                height: 80,
              ),
              SizedBox(height: 8),
              Text(
                "تسجيل",
                style: GoogleFonts.tajawal(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFB300),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "OTP",
                      style: GoogleFonts.tajawal(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFB300),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: otpController,
                      decoration: InputDecoration(
                        hintText: "رمز التحقق",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "لم تستلم رمز التأكيد؟",
                      style: GoogleFonts.tajawal(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Resend OTP tapped");
                      },
                      child: Text(
                        "إعادة الإرسال",
                        style: GoogleFonts.tajawal(
                          fontSize: 12,
                          color: Color(0xFFFFB300),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          String otp = otpController.text.trim();
                          if (otp.isNotEmpty) {
                            try {
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: otp,
                              );
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithCredential(credential);
                              if (userCredential.user != null) {
                                showToast(message: "تم التحقق بنجاح");
                                Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
                              }
                            } catch (e) {
                              showToast(message: "حدث خطأ أثناء التحقق: $e");
                            }
                          } else {
                            showToast(message: "يرجى إدخال رمز التحقق");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFB300),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "تأكيد",
                          style: GoogleFonts.tajawal(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
