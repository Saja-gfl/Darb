import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/Screens/DriverHomePage.dart';
import 'package:rem_s_appliceation9/widgets/AvailableSubscriptionsCard.dart';
import 'package:provider/provider.dart';
import '../services/UserProvider.dart';

class AvailableSubscriptionsPage extends StatefulWidget {
  const AvailableSubscriptionsPage({Key? key}) : super(key: key);

  @override
  _AvailableSubscriptionsPageState createState() =>
      _AvailableSubscriptionsPageState();
}

class _AvailableSubscriptionsPageState
    extends State<AvailableSubscriptionsPage> {
  final Color primaryColor = const Color(0xFFFFB300);
  final Color secondaryColor = const Color(0xFF76CB54);
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Sample data - replace with your actual data source
  final List<Map<String, String>> _allSubscriptions = [
    {
      'id': '12345',
      'type': 'شهري',
      'customerName': 'مرام المطيري',
      'route': 'عنيزة → بريدة',
      'pickup': 'نقطة الانطلاق الرئيسية',
      'dropoff': 'موقع العمل',
      'schedule': '7:00 صباحاً - الأحد إلى الخميس',
      'price': '500 ريال/شهرياً',
    },
    {
      'id': '12346',
      'type': 'أسبوعي',
      'customerName': 'علي أحمد',
      'route': 'البكيرية → بريدة',
      'pickup': 'المنزل',
      'dropoff': 'الجامعة',
      'schedule': '8:00 صباحاً - الأحد، الثلاثاء، الخميس',
      'price': '300 ريال/أسبوعياً',
    },
    {
      'id': '12347',
      'type': 'شهري',
      'customerName': 'سارة خالد',
      'route': 'المذنب → بريدة',
      'pickup': 'الحي الشمالي',
      'dropoff': 'المستشفى',
      'schedule': '6:30 صباحاً - الأحد إلى الخميس',
      'price': '450 ريال/شهرياً',
    },
  ];

  List<Map<String, String>> _filteredSubscriptions = [];

  @override
  void initState() {
    super.initState();
    _filteredSubscriptions = _allSubscriptions;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _filterSubscriptions();
    });
  }

  void _filterSubscriptions() {
    if (_searchQuery.isEmpty) {
      _filteredSubscriptions = _allSubscriptions;
    } else {
      _filteredSubscriptions = _allSubscriptions.where((subscription) {
        return subscription['customerName']!.contains(_searchQuery) ||
            subscription['route']!.contains(_searchQuery) ||
            subscription['id']!.contains(_searchQuery);
      }).toList();
    }
  }

  void _handleAcceptSubscription(String subscriptionId) {
    // الحصول على UserProvider لتحديث بيانات السائق
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // تحديث driverId في UserProvider عند قبول الاشتراك
    userProvider.setDriverId(subscriptionId); // حفظ ID السائق أو الرحلة

    // إزالة الاشتراك من القائمة
    setState(() {
      _allSubscriptions.removeWhere((sub) => sub['id'] == subscriptionId);
      _filterSubscriptions();
    });

    // عرض رسالة تأكيد
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم قبول الاشتراك #$subscriptionId')),
    );
  }

  void _handleRejectSubscription(String subscriptionId) {
    // Remove from list when rejected
    setState(() {
      _allSubscriptions.removeWhere((sub) => sub['id'] == subscriptionId);
      _filterSubscriptions();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم رفض الاشتراك #$subscriptionId')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      ),
      body: Column(
        children: [
          // Subscription Cards List
          Expanded(
            child: _filteredSubscriptions.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد اشتراكات متاحة',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: _filteredSubscriptions.length,
                    itemBuilder: (context, index) {
                      final subscription = _filteredSubscriptions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: SubscriptionCard(
                          subscriptionNumber: subscription['id']!,
                          type: subscription['type']!,
                          customerName: subscription['customerName']!,
                          route: subscription['route']!,
                          pickup: subscription['pickup']!,
                          dropoff: subscription['dropoff']!,
                          schedule: subscription['schedule']!,
                          price: subscription['price']!,
                          onAccept: () =>
                              _handleAcceptSubscription(subscription['id']!),
                          onReject: () =>
                              _handleRejectSubscription(subscription['id']!),
                          primaryColor: primaryColor,
                          secondaryColor: secondaryColor,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
