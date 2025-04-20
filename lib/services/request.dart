import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/core/utils/show_toast.dart';
import 'dart:math';

import 'UserProvider.dart'; // لإضافة مكتبة Random

//ينشئ رقم للرحله
String generateShortTripId() {
  final random = Random();
  return (100000 + random.nextInt(900000))
      .toString(); // رقم عشوائي بين 100000 و999999
}

String generateRequestId() {
  final random = Random();
  String randomNumber = (100000 + random.nextInt(900000)).toString();
  return 'R$randomNumber'; // مثال: R534829
}
//اذا اختار اليوزر السائق المناسب
//مين حذف الدالة ؟

//انشاء دكيومنت للاشتراك
Future<String> submitRequest(
  BuildContext context,
  String driverId,
  //double price,
  String userId,
  Map<String, dynamic> subscriptionData, // بيانات الاشتراك
  //Map<String, dynamic> homeLocation, // إضافة homeLocation
  //String homeLocation, // إضافة homeLocation
) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final userId = userProvider.uid; // معرف المستخدم
  final userName = userProvider.userName ?? "unknown_user"; // اسم المستخدم
  final userPhone =
      userProvider.phoneNumber ?? "unknown_phone"; // رقم هاتف المستخدم

  //final userId = FirebaseAuth.instance.currentUser;

  //String userId = "testuser"; // temp userId for testing

  //if (userId != null) {
  try {
    String tripId = generateRequestId(); // إنشاء رقم الرحلة الفريد
    subscriptionData['tripId'] = tripId; // إضافة رقم الرحلة إلى بيانات الاشتراك

    //subscriptionData['homeLocation'] =homeLocation;

    // إرسال الطلب إلى قاعدة البيانات في Firestore
    await FirebaseFirestore.instance
        .collection('rideRequests')
        .doc(tripId)
        .set({
      'tripId': tripId, // رقم الرحلة الفريد
      'driverId': driverId,
      'type': subscriptionData['type'],
      'homeLocation': subscriptionData['homeLocation'], // إضافة homeLocation
      'workLocation':
          subscriptionData['workLocation'], // الموقع الذي يعمل فيه المستخدم
      'price': subscriptionData['price'], // السعر المتفق علي
      "schedule": subscriptionData['schedule'], // جدول الرحلة (تاريخ ووقت)
      'fromLocation':
          subscriptionData['from'], // الموقع الذي انطلق منه المستخدم
      'toLocation':
          subscriptionData['to'], // الموقع الذي يريد المستخدم الذهاب إليه
      'startDate': subscriptionData['startDate'], // وقت بدء الرحلة

      // 'createdAt': Timestamp.now(),  // تاريخ ووقت الطلب
    });
    //add users to the request

    await FirebaseFirestore.instance
        .collection('rideRequests')
        .doc(tripId)
        .collection('users')
        .doc(userId) // استخدام userId بدلاً من tripId
        .set({
      'userName': userName, // معرف المستخدم
      'userphone': userPhone, // رقم هاتف المستخدم
      //'homeLocation': homeLocation, // إضافة homeLocation
      'sub_status': 'معلق',
      // 'userphone': userId.phoneNumber, // رقم هاتف المستخدم
      'createdAt': Timestamp.now(), // تاريخ ووقت الطلب
    });
    // إظهار رسالة تأكيد للمستخدم
    showToast(message: "تم إرسال طلب الاشتراك بنجاح");
    return tripId; // إرجاع رقم الرحلة الفريد
  } catch (e) {
    print("خطأ في رفع الطلب: $e");
    showToast(message: "حدث خطأ أثناء إرسال الطلب");
    rethrow;
  }
  /*} else {
    showToast(message: "المستخدم غير مسجل الدخول");
  }*/
  throw Exception("حدث خطأ غير متوقع أثناء إنشاء الطلب");
}

//لقبول الطلب من السائق
Future<void> updateRequestStatus(
    String tripId, String userId, String sub_status) async {
  try {
    await FirebaseFirestore.instance
        .collection('rideRequests')
        .doc(tripId)
        .collection('users')
        .doc(userId) // استخدام userId بدلاً من tripId
        .update({
      'sub_status': sub_status, // تحديث الحالة (مقبول أو مرفوض)
    });

    // إشعار للمستخدم
    showToast(message: "تم تحديث حالة الطلب إلى $sub_status");
  } catch (e) {
    print("خطأ في تحديث حالة الطلب: $e");
  }
}

//بحث عن بيانات الاشتراك باستخدام رقم الرحله
Future<Map<String, dynamic>?> getRequestByTripId(String tripId) async {
  try {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('rideRequests')
        .doc(tripId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.data() as Map<String, dynamic>;
    } else {
      print("❌ لم يتم العثور على اشتراك برقم الرحلة: $tripId");
      return null; // لا يوجد مستند يطابق الرقم
    }
  } catch (e) {
    print("خطأ في جلب الطلب: $e");
    return null;
  }
} //end

//جلب الرحلات النشطة للمستخدم الحالي
Future<List<Map<String, dynamic>>> getActiveTripsForUser(String userId) async {
  try {
    // الحصول على اسم المستخدم الحالي
    QuerySnapshot rideRequestsSnapshot =
        await FirebaseFirestore.instance.collection('rideRequests').get();

    List<Map<String, dynamic>> activeSubscriptions = [];

    for (var doc in rideRequestsSnapshot.docs) {
      DocumentSnapshot userDoc =
          await doc.reference.collection('users').doc(userId).get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        if (userData['sub_status'] == 'نشط') {
          final rideData = doc.data() as Map<String, dynamic>;
          rideData['tripId'] = doc.id;
          rideData['sub_status'] = userData['sub_status']; // حالة الاشتراك
          activeSubscriptions.add(rideData);
        }
      }
    }
    return activeSubscriptions;
  } catch (e) {
    print("خطأ في جلب الرحلات النشطة: $e");
    return [];
  }
}

Future<void> check_Sub_tatus(
    String tripId, String userId) async {
  try {
    // جلب بيانات الاشتراك
    final subscriptionData = await getRequestByTripId(tripId);

    if (subscriptionData != null) {
      final startDate = subscriptionData['startDate'] as Timestamp?;
      final subscriptionType =
          subscriptionData['type']; // نوع الاشتراك (شهر/أسبوع)

      if (startDate != null) {
        final startDateTime = startDate.toDate();
        final now = DateTime.now();

        // تحديد مدة الاشتراك بناءً على النوع
        final subscriptionDuration =
            subscriptionType == 'شهري' ? Duration(days: 30) : Duration(days: 7);

        // التحقق إذا انتهت مدة الاشتراك
        if (now.isAfter(startDateTime.add(subscriptionDuration))) {
          // تحديث حالة الاشتراك إلى "منتهية"
          await FirebaseFirestore.instance
              .collection('rideRequests')
              .doc(tripId)
              .update({
            'sub_status': 'منتهية',
          });

          print("✅ تم تحديث حالة الاشتراك إلى منتهية");
        }
      }
    }
  } catch (e) {
    print("❌ خطأ أثناء التحقق من حالة الاشتراك: $e");
  }
}
