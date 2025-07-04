import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/Screens/userhome_pageM.dart';
import 'package:rem_s_appliceation9/services/rating.dart';
import '../services/NotifProvider .dart';
import '../services/UserProvider.dart';
import 'dart:async';
// لإضافة مكتبة Random

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'positiveRating': positiveRating,
      'positiveComment': positiveComment,
      'negativeRating': negativeRating,
      'negativeComment': negativeComment,
      'avatarUrl': avatarUrl,
      'ratings': ratings,
    };
  }
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
  bool isLoading = true; // متغير لتتبع حالة التحميل
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

    Future.delayed(Duration.zero, () async {
      setState(() {
        isLoading = true; // بدء التحميل
      });

      List<Driver> results = await filterDrivers(
        fromLocation: widget.fromLocation,
        subscriptionType: widget.subscriptionType,
        toLocation: widget.toLocation,
        price: widget.priceRange,
      );

      setState(() {
        filteredDrivers = results;
        isLoading = false; // انتهاء التحميل
      });
    });
  }

// استدعاء الفلترة عند تحميل الصفحة
  Future<List<Driver>> filterDrivers({
    required String fromLocation,
    required String subscriptionType,
    required String toLocation,
    required double price,
  }) async {
    try {
      // استعلام لتصفية السائقين في Firestore بناءً على المعايير المدخلة
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('driverdata')
          .where('address', isEqualTo: fromLocation) // تصفية حسب الموقع
          .where('subscriptionType', isEqualTo: subscriptionType)
          .where('acceptedLocations', isEqualTo: toLocation) // تصفية حسب الموقع
          .where('price', isLessThanOrEqualTo: price) // تصفية حسب السعر
          .get();
      print(
          'Query Results: ${snapshot.docs.length}'); // طباعة عدد الوثائق المسترجعة

      // تحويل المستندات إلى قائمة من السائقين مع تقييماتهم
      List<Driver> filteredDrivers =
          await Future.wait(snapshot.docs.map((doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // جلب آخر 10 تقييمات للسائق
        List<Map<String, dynamic>> ratings =
            await RatingService().getDriverRatings(doc.id);

        return Driver(
          id: doc.id,
          name: data['name'] ?? 'غير معروف',
          status: data['status'] ?? ' متوفر',
          positiveRating: data['positiveRating'] ?? 0,
          positiveComment: data['positiveComment'] ?? 'لا توجد تعليقات',
          negativeRating: data['negativeRating'] ?? 0,
          negativeComment: data['negativeComment'] ?? 'لا توجد تعليقات',
          avatarUrl: data['avatarUrl'] ?? '',
          ratings: ratings.take(10).toList(), // أخذ آخر 10 تقييمات فقط
        );
      }).toList());

      return filteredDrivers;
    } catch (e) {
      print("خطأ في تصفية السائقين: $e");
      return [];
    }
  }

  Future<void> sendSubscriptionRequest(Map<String, dynamic> driverData) async {
    try {
      final userId = Provider.of<UserProvider>(context, listen: false).uid;
      final passengerName = Provider.of<UserProvider>(context, listen: false)
          .userName; // اسم الراكب من مزود المستخدم
      final tripId = widget.tripId; //

      await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .update({
        'driverId': driverData['id'], // UID الخاص بالسائق
        //'sub_status':(معلق) مكرر ماله داعي
        'driverData': {
          'id': driverData['id'],
          'name': driverData['name'],
          'phone': driverData['phone'],
          'carModel': driverData['carType'],
        }, // إضافة بيانات السائق كـ Map
        'updatedAt': Timestamp.now(), // وقت التحديث
      });
      // 2. جلب بيانات السائق (للحصول على fcmToken)
      final driverDoc = await FirebaseFirestore.instance
          .collection('driverdata')
          .doc(driverData['id'])
          .get();
      final String? driverFcm = driverDoc['fcmToken'];

      if (driverFcm != null) {
        final notificationProvider =
            Provider.of<NotificationProvider>(context, listen: false);
        await notificationProvider.sendFCMNotificationV1(
          driverFcm,
          'طلب اشتراك جديد',
          'لديك طلب اشتراك جديد للراكب $passengerName',
        );
      } else {
        print('❌ لا يوجد fcmToken لهذا السائق.');
      }
      // إظهار رسالة تأكيد للمستخدم
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم ارسال الطلب  للسائق")),
      );

      // الانتقال إلى صفحة UserHomePage
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UserHomePage()), // استبدال هذا بالصفحة المناسبة
      );
    } catch (e) {
      print("خطأ في إرسال طلب الاشتراك: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("حدث خطأ أثناء إرسال الطلب")),
      );
    }
    //final requestId = generateRequestId(); // توليد ID عشوائي للطلب

    /*await FirebaseFirestore.instance
        .collection('subscriptionRequests')
        .doc(requestId)
        .set({
      "requestId": requestId,
      "tripId": widget.tripId,
      "userId": userId,
      "driverId": driverData['id'], // ✅ هذا هو الـ UID الخاص بالسائق
      "driverName": driverData['name'],
      "driverPhone": driverData['phone'],
      "driverCarModel": driverData['carType'],
      "status": "معلق", // تأكد إنك تستخدم "معلق" مو "pending" حسب اللي تعرضه
      "timestamp": Timestamp.now(),
      "subscriptionData": widget.subscriptionData,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم إرسال الطلب للسائق")),
    );
  } catch (e) {
    print("❌ خطأ أثناء إرسال طلب الاشتراك: $e");
  }*/
  }

//مرام: هنا التعديل على الباك بوتن
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
          icon: const Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () async {
            bool shouldExit = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('تحذير'),
                content: const Text(
                    'إذا خرجت الآن، لن يتم إكمال عملية الاشتراك. هل أنت متأكد أنك تريد المتابعة؟'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('إلغاء'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserHomePage(),
                      ),
                    ),
                    child: const Text('نعم، أريد الخروج'),
                  ),
                ],
              ),
            );
            if (shouldExit == true) {
              if (mounted) {
                () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserHomePage()),
                    );
              }
            }
          },
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.amber, // لون مؤشر التحميل
              ),
            )
          : filteredDrivers.isEmpty
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
                        itemCount: filteredDrivers.length,
                        itemBuilder: (context, index) {
                          return DriverCard(
                            driver: filteredDrivers[index],
                            onSubscribe: () => sendSubscriptionRequest(
                                filteredDrivers[index].toMap()),
                            tripId: widget.tripId,
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

class DriverCard extends StatelessWidget {
  final Driver driver;
  final VoidCallback onSubscribe;
  final String tripId;

  const DriverCard({
    Key? key,
    required this.driver,
    required this.onSubscribe,
    required this.tripId,
  }) : super(key: key);

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
                // Added CircleAvatar here
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.amber.withOpacity(0.2),
                  child: Text(
                    driver.name.isNotEmpty ? driver.name[0] : '?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[800],
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
          // Rest of your existing code...
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
              String userName = (rating['userName'] ?? 'غير معروف');
              String formattedUserName = userName.length > 3
                  ? '${userName.substring(0, 3)}**'
                  : userName;
              String truncatedComment = (rating['comment'] ?? 'لا يوجد تعليق')
                  .split(' ')
                  .take(4)
                  .join(' ');
              return ListTile(
                title: Text(
                  truncatedComment,
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
                    onPressed: onSubscribe,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 221, 145, 21),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'طلب اشتراك ',
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
