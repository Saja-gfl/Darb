import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rem_s_appliceation9/core/utils/show_toast.dart';
import 'dart:math'; // لإضافة مكتبة Random

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
  String driverId,
  //double price,
  String userId,
  Map<String, dynamic> subscriptionData, // بيانات الاشتراك
  //Map<String, dynamic> homeLocation, // إضافة homeLocation
  //String homeLocation, // إضافة homeLocation
) async {
  //final user = FirebaseAuth.instance.currentUser;

  String userId = "testuser"; // temp userId for testing

  if (userId != null) {
    try {
      String tripId = generateShortTripId(); // إنشاء رقم الرحلة الفريد
      subscriptionData['tripId'] =
          tripId; // إضافة رقم الرحلة إلى بيانات الاشتراك

      //subscriptionData['homeLocation'] =homeLocation;

      // إرسال الطلب إلى قاعدة البيانات في Firestore
      await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .set({
        'tripId': tripId, // رقم الرحلة الفريد
        'driverId': driverId,
        'type': subscriptionData['type'],
        'homeLocation':
            subscriptionData['homeLocation'], // إضافة homeLocation
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
          .doc(userId)
          .set({
        //'userId': userId, // معرف المستخدم
        //'homeLocation': homeLocation, // إضافة homeLocation
        'sub_status': 'pending',
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
  } else {
    showToast(message: "المستخدم غير مسجل الدخول");
  }
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

