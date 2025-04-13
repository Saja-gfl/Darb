import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rem_s_appliceation9/services/rating.dart';

class Driver {
  final String id;
  final String name;
  final String status;
  final int positiveRating;
  final String positiveComment;
  final int negativeRating;
  final String negativeComment;
  final String avatarUrl;
  final List<Map<String, dynamic>> ratings; // قائمة التقييمات

  Driver({
    required this.id,
    required this.name,
    required this.status,
    required this.positiveRating,
    required this.positiveComment,
    required this.negativeRating,
    required this.negativeComment,
    required this.avatarUrl,
    required this.ratings,
  });
}

class DriverSelectionPage extends StatefulWidget {
  final String fromLocation;
  final String toLocation;
  final String subscriptionType;
  final double priceRange;
  final List<String> selectedDays;
  final Map<String, dynamic> subscriptionData; // بيانات الاشتراك
  final String tripId; // معرف الاشتراك

  const DriverSelectionPage({
    Key? key,
    required this.fromLocation,
    required this.toLocation,
    required this.subscriptionType,
    required this.priceRange,
    required this.selectedDays,
    required this.subscriptionData,
    required this.tripId,
  }) : super(key: key);

  @override
  State<DriverSelectionPage> createState() => _DriverSelectionPageState();
}

class _DriverSelectionPageState extends State<DriverSelectionPage> {
  List<Driver> filteredDrivers = [];
  final List<Driver> drivers = [
    Driver(
      id: '1',
      name: 'مهند',
      status: 'متوفر حالياً',
      positiveRating: 5,
      positiveComment: 'ملتزم وبالوقت',
      negativeRating: 2,
      negativeComment: 'سعر مرتفع جداً',
      avatarUrl: '',
      ratings: [],
    ),
    Driver(
      id: '2',
      name: 'عبدالله المطيري',
      status: 'متوفر حالياً',
      positiveRating: 5,
      positiveComment: 'ساعدني حيال اسعار توصيل مناسبة',
      negativeRating: 2,
      negativeComment: 'بطيء في الوصول وضعيف',
      avatarUrl: '',
      ratings: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    filterDrivers(); // استدعاء الفلترة عند تحميل الصفحة
  }

  Future<void> filterDrivers() async {
    try {
      Query query = FirebaseFirestore.instance.collection('driverdata');

      if (widget.fromLocation.isNotEmpty) {
        query = query.where('location', isEqualTo: widget.fromLocation);
      }
      if (widget.toLocation.isNotEmpty) {
        query =
            query.where('acceptedLocations', arrayContains: widget.toLocation);
      }
      if (widget.subscriptionType.isNotEmpty) {
        query =
            query.where('subscriptionType', isEqualTo: widget.subscriptionType);
      }

      QuerySnapshot snapshot = await query.get();
      List<Driver> filtered = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String driverId = doc.id;

        // جلب آخر 10 تقييمات للسائق
        List<Map<String, dynamic>> ratings =
            await RatingService().getDriverRatings(driverId);

        filtered.add(Driver(
          id: driverId,
          name: data['name'] ?? 'غير معروف',
          status: data['status'] ?? 'غير متوفر',
          positiveRating: data['positiveRating'] ?? 0,
          positiveComment: data['positiveComment'] ?? 'لا توجد تعليقات',
          negativeRating: data['negativeRating'] ?? 0,
          negativeComment: data['negativeComment'] ?? 'لا توجد تعليقات',
          avatarUrl: data['avatarUrl'] ?? '',
          ratings: ratings.take(10).toList(), // أخذ آخر 10 تقييمات فقط
        ));
      }

      setState(() {
        filteredDrivers = filtered;
      });
      print("تم جلب ${filteredDrivers.length} سائقين");
    } catch (e) {
      print("خطأ أثناء جلب البيانات: $e");
    }
  }

  Future<void> saveSubscription(String driverId) async {
    try {
      // إضافة معرف السائق إلى بيانات الاشتراك
      final updatedData = {
        "driverId": driverId,
        "status": driverId == null ? "معلق" : "نشط",
        "createdAt": Timestamp.now(),
      };
      await FirebaseFirestore.instance
          .collection('subscriptions')
          .doc(widget.tripId) // استخدم معرف الاشتراك
          .update(updatedData);

      Navigator.pop(context); // العودة إلى الصفحة السابقة إذا تم اختيار سائق
    } catch (e) {
      print("خطأ أثناء حفظ الاشتراك: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'قائمة بالسائقين الموافقين لطلبك',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chat_bubble_outline, color: Colors.amber),
          onPressed: () {},
        ),
      ),
      body: filteredDrivers.isEmpty
          ? const Center(
              child: Text(
                'لا توجد بيانات للسائقين المتاحين',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: drivers.length,
                    itemBuilder: (context, index) {
                      return DriverCard(
                        driver: filteredDrivers[index],
                        onSubscribe: (driverId) => saveSubscription(driverId),
                      );
                      //return DriverCard(driver: drivers[index]);
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'القبول',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class DriverCard extends StatelessWidget {
  final Driver driver;
  final Function(String) onSubscribe; // وظيفة يتم استدعاؤها عند الاشتراك

  const DriverCard({Key? key, required this.driver, required this.onSubscribe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    driver.name.isNotEmpty ? driver.name[0] : '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        driver.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        driver.status,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // عرض التقييمات
          if (driver.ratings.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              alignment: Alignment.centerRight,
              child: const Text(
                'التقييمات الأخيرة',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          if (driver.ratings.isNotEmpty)
            ...driver.ratings.map((rating) {
              return ListTile(
                title: Text(
                  rating['comment'] ?? 'لا يوجد تعليق',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 14),
                ),
                subtitle: Row(
                  textDirection: TextDirection.rtl,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 16,
                      color: index < (rating['rating'] ?? 0)
                          ? Colors.amber
                          : Colors.grey[300],
                    ),
                  ),
                ),
              );
            }).toList(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        onSubscribe(driver.id), // تمرير معرف السائق
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 221, 145, 21),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'اشتراك',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'مراسلة',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
