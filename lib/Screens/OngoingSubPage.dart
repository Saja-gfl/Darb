import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/widgets/subscription_card.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/Screens/ReviewPage.dart';
import 'package:google_fonts/google_fonts.dart';

class OngoingSubPage extends StatelessWidget {
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
          'الاشتراكات الجارية',
          style: GoogleFonts.tajawal(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Search and Filter Row
            Row(
              children: [
                // Filter Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.filter_list, size: 20, color: primaryColor),
                        SizedBox(width: 8),
                        Text(
                          'تصفية',
                          style: GoogleFonts.tajawal(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),

                // Search Field
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ابحث عن اشتراك...',
                      hintStyle: GoogleFonts.tajawal(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: primaryColor),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Subscription Type Tabs
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                      child: Text(
                        'الأيام المفضلة',
                        style: GoogleFonts.tajawal(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'أسبوعي',
                        style: GoogleFonts.tajawal(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'شهري',
                        style: GoogleFonts.tajawal(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Subscription Cards
            SubscriptionCard(
              subscriptionNumber: '#12345',
              type: 'شهري',
              route: 'عنيزة → بريدة',
              pickup: 'نقطة الانطلاق الرئيسية',
              dropoff: 'موقع العمل',
              schedule: '7:00 صباحاً - الأحد إلى الخميس',
              price: '500 ريال/شهرياً',
              driver: 'أحمد محمد',
              status: 'نشط',
              onSharePressed: () {
                // Handle share functionality
              },
              onRatePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReviewPage()),
                );
              },
            ),
            SizedBox(height: 16),
            SubscriptionCard(
              subscriptionNumber: '#12346',
              type: 'أسبوعي',
              route: 'البكيرية → بريدة',
              pickup: 'المنزل',
              dropoff: 'الجامعة',
              schedule: '8:00 صباحاً - الأحد، الثلاثاء، الخميس',
              price: '300 ريال/أسبوعياً',
              driver: 'خالد عبدالله',
              status: 'نشط',
              onSharePressed: () {
                // Handle share functionality
              },
              onRatePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReviewPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
