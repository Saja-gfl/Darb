import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/Screens/userhome_pageM.dart';

class Requestedsubpage extends StatelessWidget {
  const Requestedsubpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFFFB300)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserHomePage()),
              );
            }),
        title: Text(
          'الاشتراكات المرفوعة',
          style: GoogleFonts.getFont(
            'Inter',
            color: const Color(0xFFFFB300),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Subscription Card
            _buildSubscriptionCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard() {
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
            // Subscription Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'شهري',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  'اشتراك # 12345',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFB300),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Route Information
            _buildInfoRow('عنيزة -> بريدة', Icons.arrow_forward),
            _buildInfoRow('نقطة الانطلاق', Icons.location_on),
            _buildInfoRow('نقطة التوصيل', Icons.location_on),

            const Divider(height: 24),

            // Schedule and Price
            _buildDetailRow(
                '7:00 صباحاً - الأحد إلى الخميس', Icons.access_time),
            _buildDetailRow('500 ريال/شهرياً', Icons.attach_money),

            const Divider(height: 24),

            // Action Buttons
            _buildActionButton('تعديل الاشتراك', Icons.edit),
            _buildActionButton('قائمة السائقين', Icons.people),
            _buildActionButton('إلغاء الاشتراك', Icons.cancel,
                color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 16, color: const Color(0xFFFFB300)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon,
      {Color color = Colors.black}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: Colors.white,
          side: BorderSide(color: const Color(0xFFD4D4D4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            Icon(icon, size: 20),
          ],
        ),
      ),
    );
  }
}
