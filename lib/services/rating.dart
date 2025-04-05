import 'package:cloud_firestore/cloud_firestore.dart';

class RatingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔹 إضافة تقييم جديد
  Future<void> addRating(
      {required String userId,
      required String driverId,
      required int rating,
      String? comment}) async {
    try {
      await _firestore.collection('driverRatings').add({
        'userId': userId,
        'driverId': driverId,
        'rating': rating,
        'comment': comment ?? '', // إذا لم يكن هناك تعليق، اجعل القيمة فارغة
        'createdAt': FieldValue.serverTimestamp(), // تاريخ ووقت الإضافة
      });
      print("✅ تم إضافة التقييم بنجاح");
    } catch (e) {
      print("❌ خطأ أثناء إضافة التقييم: $e");
      throw Exception("حدث خطأ أثناء إضافة التقييم");
    }
  }

  //  الحصول على تقييمات سائق معين
  Future<List<Map<String, dynamic>>> getDriverRatings(String driverId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('driverRatings')
          .where('driverId', isEqualTo: driverId)
          .orderBy('createdAt', descending: true) // ترتيب التقييمات حسب التاريخ
          .get();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("❌ خطأ أثناء تحميل التقييمات: $e");
      throw Exception("حدث خطأ أثناء تحميل التقييمات");
    }
  }

  //  حساب متوسط التقييمات
  Future<double> calculateAverageRating(String driverId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('driverRatings')
          .where('driverId', isEqualTo: driverId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return 0.0; // إذا لم توجد تقييمات، ارجع 0.0
      }

      double totalRating = querySnapshot.docs.fold(0.0, (sum, doc) {
        return sum + (doc['rating']?.toDouble() ?? 0.0); // جمع التقييمات
      });

      return totalRating / querySnapshot.docs.length; // حساب المتوسط
    } catch (e) {
      print("❌ خطأ أثناء حساب متوسط التقييمات: $e");
      throw Exception("حدث خطأ أثناء حساب متوسط التقييمات");
    }
  }
}

// اضافة تقييم جديد
/*final driverRatingService = DriverRatingService();

Future<void> submitDriverRating(String driverId, String userId, int rating, String comment) async {
  try {
    await driverRatingService.addDriverRating(
      driverId: driverId,
      userId: userId,
      rating: rating,
      comment: comment,
    );
    print("تم إرسال التقييم بنجاح");
  } catch (e) {
    print("خطأ أثناء إرسال التقييم: $e");
  }
}*/

// عرض متوسط التقييمات
/*Future<void> showDriverAverageRating(String driverId) async {
  try {
    double averageRating = await driverRatingService.calculateDriverAverageRating(driverId);
    print("متوسط تقييم السائق: $averageRating");
  } catch (e) {
    print("خطأ أثناء عرض متوسط التقييم: $e");
  }
}*/

