import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/Screens/userhome_pageM.dart';
import 'package:rem_s_appliceation9/widgets/requestedsub_card.dart';

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
  bool useFakeData = true; // Set to true for testing

  // Fake data for testing
  final List<Map<String, dynamic>> _fakeSubscriptions = [
    {
      'tripId': 'SUB12345',
      'type': 'شهري',
      'fromLocation': 'الرياض',
      'toLocation': 'الخبر',
      'homeLocation': 'حي النخيل',
      'workLocation': 'الظهران',
      'schedule': '7:00 صباحاً - الأحد إلى الخميس',
      'price': 800,
      'startDate': '01/06/2023',
      'endDate': '30/06/2023',
      'sub_status': 'معلق',
      'driverData': {
        'name': 'أحمد محمد',
        'carType': 'كامري 2020',
        'phone': '0551234567',
      },
    },
    {
      'tripId': 'SUB67890',
      'type': 'أسبوعي',
      'fromLocation': 'جدة',
      'toLocation': 'مكة',
      'homeLocation': 'حي الصفا',
      'workLocation': 'الحرم المكي',
      'schedule': '6:30 صباحاً - الأحد، الثلاثاء، الخميس',
      'price': 500,
      'startDate': '05/06/2023',
      'endDate': '30/06/2023',
      'sub_status': 'مرفوض',
      'driverData': {
        'name': 'خالد عبدالله',
        'carType': 'أكسنت 2022',
        'phone': '0557654321',
      },
    },
  ];

  @override
  void initState() {
    super.initState();
    _fetchSubscriptions();
  }

  Future<void> _fetchSubscriptions() async {
    setState(() => isLoading = true);

    if (useFakeData) {
      // Use fake data for testing
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        subscriptions = _fakeSubscriptions;
        isLoading = false;
      });
      return;
    }

    // Original Firebase code
    try {
      final userId = Provider.of<UserProvider>(context, listen: false).uid;
      final data = await getPendingOrRejectedTripsForUser(userId!);

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
      final confirm = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('تأكيد الإلغاء'),
          content: const Text('هل أنت متأكد أنك تريد إلغاء هذا الاشتراك؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('تراجع'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('تأكيد', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );

      if (confirm != true) return;

      if (!useFakeData) {
        // Original Firebase cancellation code
        await FirebaseFirestore.instance
            .collection('rideRequests')
            .doc(tripId)
            .update({'sub_status': 'منتهية'});

        await FirebaseFirestore.instance
            .collection('rideRequests')
            .doc(tripId)
            .collection('users')
            .doc(userId)
            .delete();
      }

      // Update UI
      setState(() {
        subscriptions.removeWhere((sub) => sub['tripId'] == tripId);
      });

      // Update provider
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
                    return RequestedsubCard(
                      subscription: subscription,
                      onCancel: (tripId) {
                        final userId =
                            Provider.of<UserProvider>(context, listen: false)
                                .uid;
                        _cancelSubscription(tripId, userId!);
                      },
                    );
                  },
                ),
    );
  }

  // Keep these methods for potential other usage
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
      {Color color = Colors.black, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFD4D4D4)),
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
