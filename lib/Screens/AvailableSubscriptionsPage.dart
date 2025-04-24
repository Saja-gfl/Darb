import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
import 'package:rem_s_appliceation9/Screens/DriverHomePage.dart';
import 'package:rem_s_appliceation9/widgets/AvailableSubscriptionsCard.dart';
=======
>>>>>>> 6e69b6c5df01dd81b6bd6f6b4a31dde40752d8a1
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/Screens/userhome_pageM.dart';
import 'package:rem_s_appliceation9/core/utils/show_toast.dart';
import 'package:rem_s_appliceation9/services/UserProvider.dart';
import 'package:rem_s_appliceation9/services/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rem_s_appliceation9/services/Firestore.dart';
import 'package:rem_s_appliceation9/services/ChatService.dart';
import 'package:rem_s_appliceation9/Screens/userhome_pageM.dart';

class AvailableSubscriptionsPage extends StatefulWidget {
  const AvailableSubscriptionsPage({Key? key}) : super(key: key);

  @override
  _AvailableSubscriptionsPageState createState() =>
      _AvailableSubscriptionsPageState();
}
class _AvailableSubscriptionsPageState extends State<AvailableSubscriptionsPage> {
  List<Map<String, dynamic>> subscriptions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSubscriptions();
  }

  Future<void> _fetchSubscriptions() async {
    try {
      final driverId = Provider.of<UserProvider>(context, listen: false).uid;
      final data = await getPendingSubscriptionsForDriver(driverId!);
      setState(() {
        subscriptions = data;
        isLoading = false;
      });
    } catch (e) {
      showToast(message: "حدث خطأ أثناء جلب الطلبات: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> acceptSubscription(BuildContext context, String tripId, String userId, int index) async {
    try {
      print("🚀 بدء عملية قبول الاشتراك");
      print("📦 tripId: $tripId");

      // تنفيذ العمليات هنا (قبول الاشتراك)
      final userSnapshot = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .where('sub_status', isEqualTo: 'معلق')
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) {
        throw Exception("لا يوجد مستخدمين في هذه المجموعة الفرعية.");
      }

      final userDoc = userSnapshot.docs.first;

      final passengerId = userDoc['userId'] as String;
      final tripData = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .get();

      final tripStatus = tripData['status'];

      if (tripStatus != 'نشط') {
        await FirebaseFirestore.instance
            .collection('rideRequests')
            .doc(tripId)
            .update({'status': 'نشط'});
      }

      await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .doc(passengerId)
          .update({'sub_status': 'نشط'});

      // بعد القبول: إزالة الكارد من القائمة
      setState(() {
        subscriptions.removeAt(index);
      });

      // إنشاء غرفة الدردشة
      final driverId = Provider.of<UserProvider>(context, listen: false).uid;
      final chatService = ChatService();
      await chatService.createChatRoom(tripId, driverId ?? '', passengerId);

      print("✅ تم قبول الاشتراك بنجاح.");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("تم قبول الاشتراك.")));
    } catch (e) {
      print("خطأ أثناء القبول: $e");
    }
  }

  Future<void> rejectSubscription(BuildContext context, String tripId, String userId, int index) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .where('sub_status', isEqualTo: 'معلق')
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) {
        throw Exception("لم يتم العثور على المستخدم داخل المجموعة الفرعية users");
      }

      final userDoc = userSnapshot.docs.first;
      final passengerId = userDoc['userId'] as String;

      await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .doc(passengerId)
          .update({'sub_status': 'مرفوض'});

      // بعد الرفض: إزالة الكارد من القائمة
      setState(() {
        subscriptions.removeAt(index);
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("تم رفض الاشتراك.")));
    } catch (e) {
      print("خطأ أثناء الرفض: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => DriverHomePage()),
  ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'الاشتراكات المتاحة',
          style: GoogleFonts.tajawal(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFFFFB300),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : subscriptions.isEmpty
              ? const Center(child: Text("لا توجد طلبات معلقة"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: subscriptions.length,
                  itemBuilder: (context, index) {
                    return _buildRequestCard(subscriptions[index], index);
                  },
                ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> subscription, int index) {
    final user = subscription['userData'];
    final driverId = Provider.of<UserProvider>(context, listen: false).uid;
    final tripId = subscription['tripId'] ?? '';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("المستخدم: ${user['name'] ?? 'غير معروف'}"),
            const Divider(height: 12),
            _buildInfoRow(
                '${subscription['fromLocation']} -> ${subscription['toLocation']}',
                Icons.directions),
            _buildInfoRow(' ${subscription['homeLocation']}:نقطة الانطلاق',
                Icons.location_on),
            _buildInfoRow('${subscription['workLocation']} : نقطة التوصيل',
                Icons.location_on),
            const Divider(height: 24),
            _buildDetailRow(
                subscription['schedule'] ?? 'غير محدد', Icons.access_time),
            _buildDetailRow(
                '${subscription['price']} ريال/شهرياً', Icons.attach_money),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () =>
                      acceptSubscription(context, tripId, driverId!, index),
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text("قبول"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton.icon(
                  onPressed: () =>
                      rejectSubscription(context, tripId, driverId!, index),
                  icon: const Icon(Icons.close, color: Colors.white),
                  label: const Text("رفض"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(icon, color: Color(0xFFFFB300)),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  Widget _buildDetailRow(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(icon, color: Color(0xFFFFB300)),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
