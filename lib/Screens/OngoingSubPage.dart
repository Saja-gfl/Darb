import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/services/request.dart';
import 'package:rem_s_appliceation9/widgets/subscription_card.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rem_s_appliceation9/core/utils/show_toast.dart';
import 'package:rem_s_appliceation9/Screens/ReviewPage.dart';

class OngoingSubPage extends StatefulWidget {
  _OngoingSubPageState createState() => _OngoingSubPageState();
}

class _OngoingSubPageState extends State<OngoingSubPage> {
  final Color primaryColor = Color(0xFFFFB300);
  final double borderRadius = 12.0;

  List<Map<String, dynamic>> subscriptions = []; // قائمة الاشتراكات
  TextEditingController searchController =
      TextEditingController(); // Controller for search field

  // تعديل دالة البحث عن الاشتراك
  Future<void> searchSubscription(String tripId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        showToast(message: 'يرجى تسجيل الدخول أولاً');
        return;
      }
      // استدعاء الدالة من ملف request.dart
      final subscriptionData = await getRequestByTripId(tripId);
      if (subscriptionData != null) {
        //تحقق من وجود المستخدم في قاعدة البيانات
        final userDoc = await FirebaseFirestore.instance
            .collection('rideRequests')
            .doc(tripId)
            .collection('users')
            .doc(user.uid)
            .get();

        String? subStatus;
        if (userDoc.exists) {
          subStatus = userDoc.data()?['sub_status'];
        }
        if (userDoc.exists) {
          subStatus = userDoc.data()?['sub_status'];
        }
        //if (subscriptionData != null) {
        // تصفية البيانات العامة فقط
        setState(() {
          subscriptions = [
            {
              'tripId': tripId,
              //رقم الساقئ عند قبول الرحله

              'subscriptionData': {
                'type': subscriptionData['type'], // نوع الاشتراك
                'price': subscriptionData['price'], // السعر
                'schedule': subscriptionData['schedule'], // الجدول
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
        // إذا لم يتم العثور على الاشتراك
        setState(() {
          subscriptions = []; // لا توجد نتائج
        });
        print("❌ لم يتم العثور على اشتراك برقم الرحلة: $tripId");
      }
    } catch (e) {
      print("خطأ أثناء البحث عن الاشتراك: $e");
    }
  }

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
          'الاشتراكات الجارية',
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
            // Search and Filter Row
            Row(
              children: [
                // Filter Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.filter_list, size: 20, color: primaryColor),
                        SizedBox(width: 8),
                        Text(
                          'تصفية',
                          style: GoogleFonts.tajawal(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),

                // Search Field
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: searchController, // Attach controller
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        searchSubscription(value); // Trigger search on submit
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'ابحث عن اشتراك...',
                      hintStyle: GoogleFonts.tajawal(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: primaryColor),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Subscription Type Tabs
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                      child: Text(
                        'الأيام المفضلة',
                        style: GoogleFonts.tajawal(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'أسبوعي',
                        style: GoogleFonts.tajawal(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'شهري',
                        style: GoogleFonts.tajawal(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Subscription Cards
            subscriptions.isNotEmpty
                ? Column(
                    children: subscriptions.map((subscription) {
                      final subscriptionData = subscription['subscriptionData'];
                      final schedule = subscriptionData['schedule'] ?? '';
                      final scheduleText = schedule is List
                          ? schedule
                              .map((day) => "${day['day']} - ${day['time']}")
                              .join(", ")
                          : schedule;

                      // عرض بطاقة الاشتراك
                      return SubscriptionCard(
                        subscriptionNumber: subscription['tripId'] ?? '',
                        type: subscriptionData['type'] ?? '',
                        route: subscriptionData['workLocation'] ?? '',
                        pickup: subscriptionData['from'] ?? '',
                        dropoff: subscriptionData['to'] ?? '',
                        schedule: scheduleText,
                        price: subscriptionData['price'] ?? '',
                        sub_status:
                            subscriptionData['sub_status'] ?? 'غير معروف',
                        driverId: subscriptionData['driverId'] ??
                            '', // تمرير driverId
                        onSharePressed: () {
                          // Handle share functionality
                        },
                        onRatePressed: () {
                          final driverId = subscriptionData['driverId'];
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
                        actionButton: ElevatedButton(
                          onPressed: () {
                            // Handle action button
                          },
                          child: Text('Button'),
                        ),
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
