import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 تحميل بيانات المستخدم (راكب أو سائق)
  Future<DocumentSnapshot?> getUserData(String userId, bool isDriver) async {
    try {
      return await _firestore
          .collection(isDriver ? 'driverdata' : 'userdata')
          .doc(userId)
          .get();
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

      // تحديث البيانات في Firestore
      await _firestore
          .collection('userdata')
          .doc(userId)
          .update(updatedData); // تحديث البيانات حسب userId
      print("✅ تم تحديث بيانات المستخدم بنجاح");
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
      };

      // إضافة بيانات السائق إذا كان المستخدم سائقًا
      if (isDriver) {
        data['carType'] = carType;
        data['plateNumber'] = plateNumber;
      } else {
        data['isDriver'] = false;
      }

      // حفظ البيانات في Firestore
      await _firestore
          .collection(isDriver ? 'driverdata' : 'userdata')
          .doc(userId)
          .set(data);
      print("✅ تم حفظ بيانات المستخدم بنجاح");
    } catch (e) {
      print("❌ خطأ أثناء حفظ البيانات: $e");
    }
  }
}
