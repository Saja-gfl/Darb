import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/widgets/subscription_card.dart';
import 'package:rem_s_appliceation9/widgets/custom_text_form_field.dart';

class NumberSubPage extends StatelessWidget {
  final Map<String, dynamic> subscriptionData;
  NumberSubPage({required this.subscriptionData});
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFFFFB300);
    final Color secondaryColor = Color(0xFF76CB54);
    final Color backgroundColor = Colors.white;
    final Color textColor = Colors.black;
    final double borderRadius = 12.0;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'رقم الاشتراك',
          style: GoogleFonts.tajawal(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Subscription Info Card
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Subscription Number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'شهري',
                          style: GoogleFonts.tajawal(
                            color: textColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        'اشتراك #12345',
                        style: GoogleFonts.tajawal(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 24, color: Colors.grey[300]),

                  // Route Info
                  _buildInfoRow(Icons.place, 'عنيزة → بريدة'),
                  SizedBox(height: 12),
                  _buildInfoRow(
                      Icons.location_on, 'نقطة الانطلاق: الموقع الرئيسي'),
                  SizedBox(height: 12),
                  _buildInfoRow(Icons.location_on, 'نقطة الوصول: موقع العمل'),
                  SizedBox(height: 12),
                  _buildInfoRow(
                      Icons.access_time, '7:00 صباحاً - الأحد إلى الخميس'),
                  SizedBox(height: 12),
                  _buildInfoRow(Icons.attach_money, '500 ريال/شهرياً'),
                  SizedBox(height: 12),
                  _buildInfoRow(Icons.person, 'السائق: أحمد محمد'),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Subscription Status
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'حالة الاشتراك:',
                    style: GoogleFonts.tajawal(
                      color: textColor,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'نشط',
                      style: GoogleFonts.tajawal(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    child: Text(
                      'تعديل',
                      style: GoogleFonts.tajawal(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    child: Text(
                      'إلغاء الاشتراك',
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: GoogleFonts.tajawal(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        SizedBox(width: 8),
        Icon(icon, size: 20, color: Color(0xFFFFB300)),
      ],
    );
  }
}
