import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatelessWidget {
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
              // Logo
              Image.asset(
                "assets/images/img_5935976241859510486.png", // Replace with your logo asset
                height: 80,
              ),

              SizedBox(height: 8),

              // "تسجيل" (Registration)
              Text(
                "تسجيل",
                style: GoogleFonts.tajawal(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFB300),
                ),
              ),

              SizedBox(height: 20),

              // OTP Container
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
                    // OTP Label
                    Text(
                      "OTP",
                      style: GoogleFonts.tajawal(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFB300),
                      ),
                    ),

                    SizedBox(height: 16),

                    // OTP Input Fields
                    PinCodeTextField(
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      textStyle: TextStyle(fontSize: 20),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        fieldWidth: 40,
                        inactiveColor: Colors.grey.shade400,
                        activeColor: Color(0xFFFFB300),
                        selectedColor: Color(0xFFFFB300),
                      ),
                      onChanged: (value) {},
                      appContext: context,
                    ),

                    SizedBox(height: 8),

                    // Resend OTP Option
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

                    // Confirm Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          print("Confirm button pressed");
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
