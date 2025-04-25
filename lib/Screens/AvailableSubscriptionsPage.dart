import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/widgets/AvailableSubscriptionsCard.dart';
import 'package:provider/provider.dart';
import '../services/UserProvider.dart';
import '../services/request.dart';
import '../core/utils/show_toast.dart';
import '../services/Firestore.dart';
import '../services/chatService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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



  List<Map<String, dynamic>> subscriptions = [];
  bool isLoading = true;
  List<Map<String, String>> _filteredSubscriptions = [];

  @override
  void initState() {
    super.initState();
    // _filteredSubscriptions = _allSubscriptions;
    //  _searchController.addListener(_onSearchChanged);
    _fetchSubscriptions();
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

    final data = await getPendingSubscriptionsForDriver(driverId);

    final filteredData = data.where((sub) {
      return sub['sub_status'] == 'معلق';
    }).toList();

    setState(() {
      subscriptions = filteredData;
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


  // @override
  // void dispose() {
  //   _searchController.removeListener(_onSearchChanged);
  //   _searchController.dispose();
  //   super.dispose();
  // }

  // void _onSearchChanged() {
  //   setState(() {
  //     _searchQuery = _searchController.text;
  //     _filterSubscriptions();
  //   });
  // }

  // void _filterSubscriptions() {
  //   if (_searchQuery.isEmpty) {
  //     _filteredSubscriptions = _allSubscriptions;
  //   } else {
  //     _filteredSubscriptions = _allSubscriptions.where((subscription) {
  //       return subscription['customerName']!.contains(_searchQuery) ||
  //           subscription['route']!.contains(_searchQuery) ||
  //           subscription['id']!.contains(_searchQuery);
  //     }).toList();
  //   }
  // }

  // void _handleAcceptSubscription(String subscriptionId) {
  //   // الحصول على UserProvider لتحديث بيانات السائق
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);

  //   // تحديث driverId في UserProvider عند قبول الاشتراك
  //   userProvider.setDriverId(subscriptionId); // حفظ ID السائق أو الرحلة

  //   // إزالة الاشتراك من القائمة
  //   setState(() {
  //     // _allSubscriptions.removeWhere((sub) => sub['id'] == subscriptionId);
  //     // _filterSubscriptions();
  //   });

  //   // عرض رسالة تأكيد
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('تم قبول الاشتراك #$subscriptionId')),
  //   );
  // }

  // void _handleRejectSubscription(String subscriptionId) {
  //   // Remove from list when rejected
  //   // setState(() {
  //   //   _allSubscriptions.removeWhere((sub) => sub['id'] == subscriptionId);
  //   //   _filterSubscriptions();
  //   // });
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('تم رفض الاشتراك #$subscriptionId')),
  //   );
  // }

  Widget _buildFilterOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title),
      trailing: Checkbox(
        value: false, // You would manage this state properly
        onChanged: (value) {},
      ),
      onTap: () {},
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
          'طلبات الاشتراك ',
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
            child: subscriptions.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد اشتراكات متاحة',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: subscriptions.length,
                    itemBuilder: (context, index) {
                      final subscription = subscriptions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: SubscriptionCard(
subscriptionNumber: subscription['tripId'] ?? '',
type: subscription['type'] ?? '',
customerName: subscription['userName'] ?? 'الاسم غير متوفر',
route: '${subscription['fromLocation'] ?? ''} -> ${subscription['toLocation'] ?? ''}',
pickup: subscription['homeLocation'] ?? 'لم يحدد بعد',
dropoff: subscription['workLocation'] ?? '',
schedule: subscription['schedule'] ?? '',
price: subscription['price'] ?? '',

                          onAccept: () {
	                            final tripId = subscription['tripId']!;
                            final userId = Provider.of<UserProvider>(context, listen: false).uid;
                            if (userId != null) {
                              acceptSubscription(context, tripId, userId, index);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("تعذر الحصول على معرف المستخدم.")),
                              );
                            }
                          },
onReject: () {
  final tripId = subscription['tripId']!;
  final userId = Provider.of<UserProvider>(context, listen: false).uid;
  if (userId != null) {
    rejectSubscription(context, tripId, userId, index);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تعذر الحصول على معرف المستخدم.")),
    );
  }
},

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
