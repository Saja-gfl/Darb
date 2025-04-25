import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/widgets/driver_ongoing_sub_card.dart';

class DriverOngoingSubPage extends StatefulWidget {
  const DriverOngoingSubPage({Key? key}) : super(key: key);

  @override
  _DriverOngoingSubPageState createState() => _DriverOngoingSubPageState();
}

class _DriverOngoingSubPageState extends State<DriverOngoingSubPage> {
  final Color primaryColor = const Color(0xFFFFB300);
  final Color secondaryColor = const Color(0xFF76CB54);

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
    setState(() {
      final index =
          _allSubscriptions.indexWhere((sub) => sub['id'] == subscriptionId);
      if (index != -1) {
        _allSubscriptions[index]['status'] = 'ended';
      }
    });
  }

  void _acceptSubscription(String subscriptionId) {
    setState(() {
      final index =
          _allSubscriptions.indexWhere((sub) => sub['id'] == subscriptionId);
      if (index != -1) {
        _allSubscriptions[index]['status'] = 'active';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم قبول الاشتراك بنجاح')),
    );
  }

  void _rejectSubscription(String subscriptionId) {
    setState(() {
      final index =
          _allSubscriptions.indexWhere((sub) => sub['id'] == subscriptionId);
      if (index != -1) {
        _allSubscriptions[index]['status'] = 'rejected';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم رفض الاشتراك بنجاح')),
    );
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _allSubscriptions.length,
        itemBuilder: (context, index) {
          return DriverOngoingSubCard(
            subscription: _allSubscriptions[index],
            primaryColor: primaryColor,
            onEndSubscription: _endSubscription,
          );
        },
      ),
    );
  }
}
