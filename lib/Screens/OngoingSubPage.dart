import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/Screens/ReviewPage.dart';

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
            _buildSubscriptionCard(
              subscriptionNumber: '#12345',
              type: 'شهري',
              route: 'عنيزة → بريدة',
              pickup: 'نقطة الانطلاق الرئيسية',
              dropoff: 'موقع العمل',
              schedule: '7:00 صباحاً - الأحد إلى الخميس',
              price: '500 ريال/شهرياً',
              driver: 'أحمد محمد',
              status: 'نشط',
              context: context,
            ),
            SizedBox(height: 16),
            _buildSubscriptionCard(
              subscriptionNumber: '#12346',
              type: 'أسبوعي',
              route: 'البكيرية → بريدة',
              pickup: 'المنزل',
              dropoff: 'الجامعة',
              schedule: '8:00 صباحاً - الأحد، الثلاثاء، الخميس',
              price: '300 ريال/أسبوعياً',
              driver: 'خالد عبدالله',
              status: 'نشط',
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String subscriptionNumber,
    required String type,
    required String route,
    required String pickup,
    required String dropoff,
    required String schedule,
    required String price,
    required String driver,
    required String status,
    required BuildContext context,
  }) {
    final Color primaryColor = Color(0xFFFFB300);
    final Color secondaryColor = Color(0xFF76CB54);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Header with status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    type,
                    style: GoogleFonts.tajawal(
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  subscriptionNumber,
                  style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Divider(height: 24, color: Colors.grey[300]),

            // Route Info
            _buildInfoRow(Icons.place, route),
            SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, 'انطلاق: $pickup'),
            SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, 'وصول: $dropoff'),
            SizedBox(height: 12),
            _buildInfoRow(Icons.access_time, schedule),
            SizedBox(height: 12),
            _buildInfoRow(Icons.attach_money, price),
            SizedBox(height: 12),
            _buildInfoRow(Icons.person, 'السائق: $driver'),
            SizedBox(height: 16),

            // Status and Actions
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.tajawal(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.share, color: primaryColor),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.star, color: primaryColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReviewPage()),
                    );
                  },
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
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(width: 8),
        Icon(icon, size: 20, color: Color(0xFFFFB300)),
      ],
    );
  }
}
