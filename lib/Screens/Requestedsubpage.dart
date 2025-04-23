import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/Screens/userhome_pageM.dart';

import '../core/utils/show_toast.dart';
import '../services/UserProvider.dart';
import '../services/request.dart';

class Requestedsubpage extends StatefulWidget {
  const Requestedsubpage({Key? key}) : super(key: key);

  @override
  _RequestedsubpageState createState() => _RequestedsubpageState();
}

class _RequestedsubpageState extends State<Requestedsubpage> {
  List<Map<String, dynamic>> subscriptions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSubscriptions();
  }

  Future<void> _fetchSubscriptions() async {
    try {
      // استبدل userId بمعرف المستخدم الحالي
      final userId = Provider.of<UserProvider>(context, listen: false).uid;
      final data = await getPendingOrRejectedTripsForUser(userId!);

      // تصفية الاشتراكات بناءً على حالة الاشتراك
      final filteredData = data.where((sub) {
        return sub['sub_status'] == 'معلق' || sub['sub_status'] == 'مرفوض';
      }).toList();

      setState(() {
        subscriptions = filteredData;
        isLoading = false;
      });
    } catch (e) {
      showToast(message: "حدث خطأ أثناء جلب البيانات: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _cancelSubscription(String tripId, String userId) async {
    try {
      // تحديث حالة الاشتراك إلى "منتهية"
      await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .update({'sub_status': 'منتهية'});

      // حذف بيانات المستخدم من مجموعة "users" داخل الرحلة
      await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .doc(userId)
          .delete();

      // حذف بيانات الرحلة من البروفايدر
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setTripId('');

      showToast(message: "تم إلغاء الاشتراك بنجاح");
    } catch (e) {
      showToast(message: "حدث خطأ أثناء إلغاء الاشتراك: $e");
    }
  }

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : subscriptions.isEmpty
              ? const Center(child: Text("لا توجد اشتراكات لعرضها"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: subscriptions.length,
                  itemBuilder: (context, index) {
                    final subscription = subscriptions[index];
                    return _buildSubscriptionCard(subscription);
                  },
                ),
    );
  }

  Widget _buildSubscriptionCard(Map<String, dynamic> subscription) {
    print(subscription['sub_status']);
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
                    subscription['type'] ?? 'غير محدد',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  'اشتراك # ${subscription['tripId']}',
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
            _buildInfoRow(
                '${subscription['fromLocation']} -> ${subscription['toLocation']}',
                Icons.directions),
            _buildInfoRow(' ${subscription['homeLocation']}:نقطة الانطلاق',
                Icons.location_on),
            _buildInfoRow('${subscription['workLocation']} : نقطة التوصيل',
                Icons.location_on),
            _buildInfoRow(' ${subscription['driverData']['name']} :اسم السائق',
                Icons.person),

            const Divider(height: 24),

            // Schedule and Price
            _buildDetailRow(
                subscription['schedule'] ?? 'غير محدد', Icons.access_time),
            _buildDetailRow(
                '${subscription['price']} ريال/شهرياً', Icons.attach_money),

            const Divider(height: 24),

            // Subscription Status
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFF5F5F5), // لون الخلفية الرمادي الفاتح
                    borderRadius: BorderRadius.circular(20), // الحواف الدائرية
                  ),
                  child: Text(
                    subscription['sub_status'] ?? 'غير محدد',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey, // لون النص الرمادي
                    ),
                  ),
                ),
              ],
            ),

            // Action Buttons
            _buildActionButton(
            'إلغاء الاشتراك',
            Icons.cancel,
            color: Colors.red,
            onPressed: () {
            final userId = Provider.of<UserProvider>(context, listen: false).uid;
              _cancelSubscription ( subscription['tripId'], userId!);
            },
            ),
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
      {Color color = Colors.black ,required VoidCallback onPressed}) {
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
        onPressed: onPressed,
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
