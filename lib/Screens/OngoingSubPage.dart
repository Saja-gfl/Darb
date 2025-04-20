import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/services/request.dart';
import 'package:rem_s_appliceation9/widgets/subscription_card.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rem_s_appliceation9/core/utils/show_toast.dart';
import 'package:rem_s_appliceation9/Screens/ReviewPage.dart';

import '../services/UserProvider.dart';

class OngoingSubPage extends StatefulWidget {
  const OngoingSubPage({Key? key}) : super(key: key);

  @override
  _OngoingSubPageState createState() => _OngoingSubPageState();
}

class _OngoingSubPageState extends State<OngoingSubPage> {
  final Color primaryColor = Color(0xFFFFB300);
  final double borderRadius = 12.0;

  TextEditingController searchController = TextEditingController();
  late String currentUserId;
  List<Map<String, dynamic>> subscriptions = []; // قائمة الاشتراكات
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    currentUserId = userProvider.uid!;
    fetchSubscriptions(); // جلب الاشتراكات النشطة عند تحميل الصفحة
  }

  Future<void> fetchSubscriptions() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      currentUserId = userProvider.uid!;
      final subs = await getActiveTripsForUser(currentUserId);
      setState(() {
        subscriptions = subs;
        isLoading = false;
      });
    } catch (e) {
      print("خطأ أثناء جلب الاشتراكات: $e");
      setState(() {
        isLoading = false; // إيقاف التحميل في حالة حدوث خطأ
      });
    }
  }

  Future<void> searchSubscription(String tripId) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.uid; // الحصول على uid من البروفايدر
      if (userId == null) {
        showToast(message: 'يرجى تسجيل الدخول أولاً');
        return;
      }

      final subscriptionData = await getRequestByTripId(tripId);
      if (subscriptionData != null) {
        //تحقق من وجود المستخدم في قاعدة البيانات
        final userDoc = await FirebaseFirestore.instance
            .collection('rideRequests') //('subscriptionRequests')
            .doc(tripId)
            .collection('users')
            .doc(userId)
            .get();

        String? subStatus;
        if (userDoc.exists) {
          subStatus = userDoc.data()?['sub_status'];
        }

        // تصفية البيانات العامة فقط
        setState(() {
          subscriptions = [
            {
              'tripId': tripId,
              //رقم الساقئ عند قبول الرحله
              'subscriptionData': {
                'type': subscriptionData['type'], // نوع الاشتراك
                'price': subscriptionData['price'], // السعر
                //'schedule': subscriptionData['schedule'], // الجدول
                'from': subscriptionData['fromLocation'], // موقع المغادرة
                'to': subscriptionData['toLocation'], // موقع الوصول
                'startDate': subscriptionData['startDate'], // تاريخ البدء
                'workLocation': subscriptionData['workLocation'], // موقع العمل
                'driverId': subscriptionData['driverId'], // رقم السائق
              },
            }
          ];
        });
      } else {
        setState(() {
          subscriptions = []; // لا توجد نتائج
        });
        print("❌ لم يتم العثور على اشتراك برقم الرحلة: $tripId");
      }
    } catch (e) {
      print("خطأ أثناء البحث عن الاشتراك: $e");
    }
  }

//هذي الاكواد لازم تنقل الى صفحة التأكيد
  Future<void> _sendSubscriptionRequest(
      Map<String, dynamic> subscription) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // تحديث بيانات Firestore
        await FirebaseFirestore.instance
            .collection('rideRequests')
            .doc(subscription['tripId'])
            .update({
          'subscriptionData.sub_status': 'قيد الانتظار',
          'subscriptionData.userId': user.uid,
        });

        // تحديث الحالة محلياً
        setState(() {
          subscription['subscriptionData']['sub_status'] = 'قيد الانتظار';
        });

        // إظهار رسالة نجاح
        showToast(message: 'تم إرسال طلب الاشتراك للسائق');
      } else {
        showToast(message: 'يرجى تسجيل الدخول أولاً');
      }
    } catch (e) {
      print('خطأ أثناء إرسال طلب الاشتراك: $e');
      showToast(message: 'حدث خطأ أثناء إرسال الطلب');
    }
  }

  void _showSubscriptionDialog(Map<String, dynamic> subscription) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تأكيد الاشتراك'),
          content: Text('هل تريد إرسال طلب الاشتراك للسائق؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // إغلاق النافذة
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // إغلاق النافذة
                await _sendSubscriptionRequest(subscription);
              },
              child: Text('نعم'),
            ),
          ],
        );
      },
    );
  }

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
          ' الاشتراكات',
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
            // Subscription Cards
            subscriptions.isNotEmpty
                ? Column(
                    children: subscriptions.map((subscription) {
                      final driverName =
                          subscription['driverData']?['name'] ?? 'غير معروف';

                      final schedule = subscription['schedule'] ?? '';
                      final scheduleText = schedule is List
                          ? schedule
                              .map((day) => "${day['day']} - ${day['time']}")
                              .join(", ")
                          : schedule;

                      // عرض بطاقة الاشتراك
                      return SubscriptionCard(
                        subscriptionNumber: subscription['tripId'] ?? '',
                        driverName: driverName,
                        type: subscription['type'] ?? '',
                        route: subscription['workLocation'] ?? '',
                        pickup: subscription['fromLocation'] ?? '',
                        dropoff: subscription['toLocation'] ?? '',
                        schedule: scheduleText,
                        price: subscription['price'] ?? '',
                        sub_status: subscription['sub_status'] ?? 'غير معروف',
                        driverId:
                            subscription['driverId'] ?? '', // تمرير driverId
                        onSharePressed: () {
                          // Handle share functionality
                        },
                        onRatePressed: () {
                          final driverId = subscription['driverId'];
                          if (driverId != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewPage(driverId: driverId),
                              ),
                            );
                          } else {
                            showToast(
                                message: 'لا يوجد سائق مرتبط بهذه الرحلة');
                          }
                        },
                      );
                    }).toList(),
                  )
                : Center(
                    child: Text(
                      'لا توجد اشتراكات حالياً',
                      style: GoogleFonts.tajawal(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
