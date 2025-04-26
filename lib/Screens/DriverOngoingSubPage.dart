import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/widgets/driver_ongoing_sub_card.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/core/utils/show_toast.dart';
import 'package:rem_s_appliceation9/services/UserProvider.dart';
import 'package:rem_s_appliceation9/services/request.dart';

class DriverOngoingSubPage extends StatefulWidget {
  const DriverOngoingSubPage({Key? key}) : super(key: key);

  @override
  _DriverOngoingSubPageState createState() => _DriverOngoingSubPageState();
}

class _DriverOngoingSubPageState extends State<DriverOngoingSubPage> {
  final Color primaryColor = const Color(0xFFFFB300);
  final Color secondaryColor = const Color(0xFF76CB54);
  List<Map<String, dynamic>> subscriptions = [];
  List<Map<String, dynamic>> activeSubscriptionsList = [];
  List<Map<String, dynamic>> expiredSubscriptionsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSubscriptions();
  }

  // Mock data
  final List<Map<String, dynamic>> _allSubscriptions = [
    {
      'id': '12345',
      'type': 'شهري',
      'customerName': 'مرام المطيري',
      'customerPhone': '0551234567',
      'route': 'عنيزة → بريدة',
      'pickupLocation': 'نقطة الانطلاق الرئيسية',
      'dropoffLocation': 'موقع العمل',
      'pickupTime': '7:00 صباحاً',
      'days': ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'],
      'price': 500,
      'status': 'active',
      'startDate': '01/10/2023',
      'endDate': '31/10/2023',
    },
    {
      'id': '12346',
      'type': 'أسبوعي',
      'customerName': 'علي أحمد',
      'customerPhone': '0557654321',
      'route': 'البكيرية → بريدة',
      'pickupLocation': 'المنزل',
      'dropoffLocation': 'الجامعة',
      'pickupTime': '8:00 صباحاً',
      'days': ['الأحد', 'الثلاثاء', 'الخميس'],
      'price': 300,
      'status': 'active',
      'startDate': '01/10/2023',
      'endDate': '07/10/2023',
    },
    {
      'id': '12347',
      'type': 'يومي',
      'customerName': 'سارة خالد',
      'customerPhone': '0559876543',
      'route': 'المذنب → بريدة',
      'pickupLocation': 'الحي الشمالي',
      'dropoffLocation': 'المستشفى',
      'pickupTime': '6:30 صباحاً',
      'days': ['يومياً'],
      'price': 50,
      'status': 'pending',
      'startDate': '01/10/2023',
      'endDate': '01/10/2023',
    },
  ];

  void _endSubscription(String subscriptionId) {
    setState(() {});
  }

  Future<void> _fetchSubscriptions() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final driverId = userProvider.uid;

      if (driverId == null) {
        print("🚨 معرف السائق غير متوفر.");
        showToast(message: "معرف السائق غير متوفر.");
        setState(() {
          isLoading = false;
        });
        return;
      }

      final data = await getSubscriptionsForDriver(driverId);

      // نحفظ كل الاشتراكات في متغير واحد
      setState(() {
        subscriptions = data;
        isLoading = false;
      });
    } catch (e) {
      print("🚨 حدث خطأ أثناء جلب البيانات: $e");
      showToast(message: "حدث خطأ أثناء جلب البيانات: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'ادارة الاشتراكات',
          style: GoogleFonts.tajawal(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.amber, // لون مؤشر التحميل
              ),
            )
          : subscriptions.isEmpty
              ? const Center(
                  child: Text(
                    'لا توجد اشتراكات حالياً',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: subscriptions.length,
                  itemBuilder: (context, index) {
                    return DriverOngoingSubCard(
                      subscription: subscriptions[index],
                      primaryColor: primaryColor,
                      onEndSubscription: _endSubscription,
                    );
                  },
                ),
    );
  }
}
