import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/Screens/ReviewPage.dart';

class SubscriptionCard extends StatelessWidget {
  final String subscriptionNumber;
  final String type;
  final String route;
  final String pickup;
  final String dropoff;
  final String schedule;
  final String price;
  final String driverName; // إضافة driverId
  final String driverId;
  final String sub_status;
  final VoidCallback onSharePressed;
  final VoidCallback onRatePressed;

  SubscriptionCard({
    required this.subscriptionNumber,
    required this.type,
    required this.route,
    required this.pickup,
    required this.dropoff,
    required this.schedule,
    required this.price,
    required this.driverName, // تمرير driverId
    required this.driverId, // إضافة driverId
    required this.sub_status,
    required this.onSharePressed,
    required this.onRatePressed,
  });

  @override
  Widget build(BuildContext context) {
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
            //_buildInfoRow(Icons.place, route),
            SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, 'من: $pickup'),
            SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, 'الى: $route'),
            SizedBox(height: 12),
           _buildInfoRow(Icons.access_time, schedule),
            SizedBox(height: 12),
            _buildInfoRow(Icons.attach_money, price),
            SizedBox(height: 12),
            _buildInfoRow(Icons.person, 'السائق: $driverName'),
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
                      sub_status,
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
                  onPressed: onSharePressed,
                ),
                IconButton(
                  icon: Icon(Icons.star, color: primaryColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewPage(
                          driverId: driverId,
                        ), // تمرير اسم السائق
                      ),
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
