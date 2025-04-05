import'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rem_s_appliceation9/core/utils/show_toast.dart';
import 'dart:math'; // لإضافة مكتبة Random

//ينشئ رقم للرحله 
String generateShortTripId() {
  final random = Random();
  return (100000 + random.nextInt(900000)).toString(); // رقم عشوائي بين 100000 و999999
}
//اذا اختار اليوزر السائق المناسب 
Future<void> submitRequest(String driverId, double price, String userId) async {
  final user = FirebaseAuth.instance.currentUser;
  
  if (user != null) {
    try {
      String tripId = generateShortTripId(); // إنشاء رقم الرحلة الفريد
      // إرسال الطلب إلى قاعدة البيانات في Firestore
      await FirebaseFirestore.instance.collection('rideRequests').add({
        'tripId': tripId,  // رقم الرحلة الفريد
        'driverId': driverId,  // السائق الذي اختاره المستخدم
        'userId': userId,  // المستخدم الذي قدم الطلب
        'price': price,  // السعر المتفق عليه
        'status': 'pending',  // حالة الطلب: "قيد الانتظار"
        'createdAt': Timestamp.now(),  // تاريخ ووقت الطلب
      });

      // إظهار رسالة تأكيد للمستخدم
      showToast(message: "تم إرسال طلب الاشتراك بنجاح");
    } catch (e) {
      print("خطأ في رفع الطلب: $e");
      showToast(message: "حدث خطأ أثناء إرسال الطلب");
    }
  } else {
    showToast(message: "المستخدم غير مسجل الدخول");
  }
}

//لقبول الطلب من السائق 
Future<void> updateRequestStatus(String requestId, String status) async {
  try {
    await FirebaseFirestore.instance
        .collection('rideRequests')
        .doc(requestId)  // هنا نستخدم معرف الطلب
        .update({
          'status': status,  // تحديث الحالة (مقبول أو مرفوض)
          'updatedAt': Timestamp.now(),  // تاريخ التحديث
        });

    // إشعار للمستخدم
    showToast(message: "تم تحديث حالة الطلب إلى $status");
  } catch (e) {
    print("خطأ في تحديث حالة الطلب: $e");
  }
}

//بحث عن بيانات الاشتراك باستخدام رقم الرحله 
Future<DocumentSnapshot?> getRequestByTripId(String tripId) async {
try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('rideRequests')
        .where('tripId', isEqualTo: tripId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first; // إرجاع أول مستند يطابق الرقم
    } else {
            print("❌ لم يتم العثور على اشتراك برقم الرحلة: $tripId");
      return null; // لا يوجد مستند يطابق الرقم
    }
  } catch (e) {
    print("خطأ في جلب الطلب: $e");
    return null;
  }
}