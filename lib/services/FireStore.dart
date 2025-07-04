import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'NotifProvider .dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 تحميل بيانات المستخدم (راكب أو سائق)
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      // جلب البيانات من مجموعة السائقين
      DocumentSnapshot driverDoc =
          await _firestore.collection('driverdata').doc(userId).get();
      if (driverDoc.exists) {
        print("✅ تم العثور على المستخدم كسائق.");
        return {
          ...driverDoc.data() as Map<String, dynamic>,
          'isDriver': true,
        };
      }

      // جلب البيانات من مجموعة المستخدمين
      DocumentSnapshot userDoc =
          await _firestore.collection('userdata').doc(userId).get();
      if (userDoc.exists) {
        print("✅ تم العثور على المستخدم كراكب.");
        return {
          ...userDoc.data() as Map<String, dynamic>,
          'isDriver': false,
        };
      }

      print("❌ لم يتم العثور على بيانات المستخدم.");
      return null;
    } catch (e) {
      print("❌ خطأ أثناء تحميل البيانات: $e");
      return null;
    }
  }

  // 🔹 تحديث بيانات المستخدم أو السائق
  Future<void> updateUserData({
    required String userId,
    required String nameController,
    required String emailController,
    required String addressController,
    required String phoneController,
    required String selectedGender,
    required bool isDriver,
    String? carType,
    String? plateNumber,
    String? acceptedLocations,
    String? passengerCount,
    String? subscriptionType,
    double? price,

  }) async {
    try {
      // بناء البيانات للتحديث
      Map<String, dynamic> updatedData = {
        'name': nameController,
        'email': emailController,
        'address': addressController,
        'phone': phoneController,
        'gender': selectedGender,

      };
      if (isDriver) {
        updatedData['carType'] = carType;
        updatedData['plateNumber'] = plateNumber;
        updatedData['acceptedLocations'] = acceptedLocations;
        updatedData['passengerCount'] = passengerCount;
        updatedData['subscriptionType'] = subscriptionType;
        updatedData['price'] = price;
      }

      // تحديث البيانات في Firestore
      await _firestore
          .collection(isDriver ? 'driverdata' : 'userdata')
          .doc(userId)
          .update(updatedData); // تحديث البيانات حسب userId
      print("✅ تم تحديث بيانات المستخدم بنجاح");

       // إرسال الإشعار بعد التحديث
    final userDoc = await _firestore
        .collection(isDriver ? 'driverdata' : 'userdata')
        .doc(userId)
        .get();

      
    if (userDoc.exists) {
      final fcmToken = userDoc['fcmToken'];
      if (fcmToken != null) {
        final notificationProvider = NotificationProvider();
        await notificationProvider.sendFCMNotificationV1(
          fcmToken,
          'تم تحديث بياناتك',
          'تم تحديث بياناتك بنجاح في النظام.',
        );
        print("✅ تم إرسال الإشعار بنجاح.");
      } else {
        print("❌ لا يوجد fcmToken لهذا المستخدم.");
      }
    }
    } catch (e) {
      print("❌ خطأ أثناء تحديث البيانات: $e");
    }
  }

  // 🔹 إنشاء بيانات جديدة للمستخدم أو السائق عند التسجيل
  Future<void> createUserData({
    required String userId,
    required String nameController,
    required String emailController,
    required String addressController,
    required String phoneController,
    required String selectedGender,
    required bool isDriver,
    String? carType,
    String? plateNumber,
  }) async {
    try {
      Map<String, dynamic> data = {
        'name': nameController,
        'email': emailController,
        'address': addressController,
        'phone': phoneController,
        'gender': selectedGender,
        'createdAt': FieldValue.serverTimestamp(),
        'isDriver': isDriver,
      };

      // إضافة بيانات السائق إذا كان المستخدم سائقًا
      if (isDriver) {
        data['carType'] = carType;
        data['plateNumber'] = plateNumber;
      }

      // حفظ البيانات في Firestore
      await _firestore
          .collection(isDriver ? 'driverdata' : 'userdata')
          .doc(userId)
          .set(data);
      print("✅ تم حفظ بيانات المستخدم بنجاح");

      // إرسال الإشعار بعد الإنشاء
    final fcmToken = data['fcmToken'];
    if (fcmToken != null) {
      final notificationProvider = NotificationProvider();
      await notificationProvider.sendFCMNotificationV1(
        fcmToken,
        'مرحبًا بك!',
        'تم إنشاء حسابك بنجاح في النظام.',
      );
      print("✅ تم إرسال الإشعار بنجاح.");
    } else {
      print("❌ لا يوجد fcmToken لهذا المستخدم.");
    }
  } catch (e) {
    print("❌ خطأ أثناء حفظ البيانات: $e");
  }
}

//جلب اسم السائق من قاعدة البيانات
  Future<String?> getUserOrDriverName(String userId, bool isDriver) async {
    try {
      // تحديد المجموعة المناسبة (userdata أو driverdata)
      String collection = isDriver ? 'driverdata' : 'userdata';

      DocumentSnapshot doc =
          await _firestore.collection(collection).doc(userId).get();
      if (doc.exists) {
        return doc['name'] as String?;
      } else {
        print(
            "❌ ${isDriver ? 'السائق' : 'المستخدم'} غير موجود في قاعدة البيانات");
        return null;
      }
    } catch (e) {
      print("❌ خطأ أثناء جلب الاسم: $e");
      return null;
    }
  }
  //اضافة رقم الرحله ال بيانات اليوزر
static Future<void> addTripIdToUser(String userId, String tripId) async {
  try {
    final userDocRef =
        FirebaseFirestore.instance.collection('userdata').doc(userId);
    final userDoc = await userDocRef.get();
    if (userDoc.exists) {
      // إذا كانت بيانات المستخدم موجودة، قم بتحديث tripId
      await userDocRef.update({
        'tripId': tripId, // تحديث رقم الرحلة
      });
      print("✅ تم تحديث tripId للمستخدم $userId إلى $tripId");
    } else {
      // إذا لم تكن بيانات المستخدم موجودة، قم بإنشائها مع tripId
      await userDocRef.set({
        'userId': userId,
        'tripId': tripId, // إضافة رقم الرحلة
        'createdAt': Timestamp.now(), // تاريخ الإنشاء
      });
      print("✅ تم إنشاء بيانات جديدة للمستخدم $userId مع tripId $tripId");
    }
  } catch (e) {
    print("❌ خطأ أثناء إضافة أو تحديث tripId للمستخدم $userId: $e");
  }
}

}
