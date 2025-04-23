import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/services/UserProvider.dart';

import '../core/utils/show_toast.dart';
import '../services/request.dart';

class SubscriptionNumberPage extends StatefulWidget {
  const SubscriptionNumberPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionNumberPage> createState() => _SubscriptionNumberPageState();
}

class _SubscriptionNumberPageState extends State<SubscriptionNumberPage> {
  final TextEditingController _searchController = TextEditingController();
  List<SubscriptionInfo> _filteredSubscriptions = [];
  List<SubscriptionInfo> _allSubscriptions = [
    // /*SubscriptionInfo(
    //   id: '12345',
    //   type: 'شهري',
    //   route: 'عنيزة -> بريدة',
    //   //  pickup: 'ميدان الملك فهد',
    //   dropoff: 'جامعة القصيم',
    //   schedule: '7:00 صباحاً - الأحد إلى الخميس',
    //   price: '500 ريال/شهرياً',
    //   driver: 'محمد أحمد',
    //   status: 'متاح',
    //   phone: '0551234567',
    // ),
    SubscriptionInfo(
      id: '67890',
      type: 'أسبوعي',
      route: 'الرياض -> الدمام',
      // pickup: 'حي النخيل',
      dropoff: 'جامعة الملك فهد',
      schedule: '6:30 صباحاً - السبت إلى الأربعاء',
      price: '300 ريال/أسبوعياً',
      driver: 'علي خالد',
      status: 'متاح',
      phone: '0559876543',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filteredSubscriptions = _allSubscriptions;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        // تحقق من وجود المستخدم في قاعدة البيانات
        final userDoc = await FirebaseFirestore.instance
            .collection('rideRequests')
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
          _filteredSubscriptions = [
            SubscriptionInfo(
              id: tripId,
              type: subscriptionData['type'] ?? 'غير محدد', // نوع الاشتراك
              route: (subscriptionData['fromLocation'] ?? 'غير معروف') +
                  " الى " +
                  (subscriptionData['toLocation'] ?? 'غير معروف'), // المسار
              //pickup:
              // subscriptionData['pickup'] ?? 'غير معروف', // نقطة الالتقاط
              dropoff: subscriptionData['workLocation'] ??
                  'غير معروف', // نقطة التسليم
              schedule:
                  subscriptionData['schedule'] ?? 'غير معروف', // الجدول الزمني
              price: subscriptionData['price'] ?? 'غير معروف', // السعر
              driver: subscriptionData['driverData']?['name'] ??
                  'غير معروف', // اسم السائق
              status: subStatus ?? 'غير معروف', // حالة الاشتراك
              phone:
                  subscriptionData['phone'] ?? 'غير معروف', // رقم هاتف السائق
            ),
          ];
        });
      } else {
        setState(() {
          _filteredSubscriptions = [];
        });
        showToast(message: 'لا توجد بيانات للاشتراك بهذا الرقم');
      }
    } catch (e) {
      print("خطأ أثناء جلب بيانات الاشتراك: $e");
    }
  }

  /* void _filterSubscriptions() {
    final query = _searchController.text;
    setState(() {
      _filteredSubscriptions = _allSubscriptions.where((sub) {
        return sub.id.toLowerCase().contains(query); //||
        //sub.route.toLowerCase().contains(query) ||
        //sub.driver.toLowerCase().contains(query);
      }).toList();
    });
  }*/

  Future<void> _messageDriver(String phone) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phone,
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تعذر فتح تطبيق الرسائل',
            textAlign: TextAlign.right,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFB300)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "الاشتراكات المتاحة",
          style: GoogleFonts.getFont(
            'Inter',
            color: const Color(0xFFFFB300),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E5E5)),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ابحث برقم الاشتراك ...',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFFADAEBC),
                    fontSize: 14,
                  ),
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFFFFB300)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                textAlign: TextAlign.right,
                onSubmitted: (query) {
                  if (query.isEmpty) {
                    showToast(message: 'يرجى إدخال رقم اشتراك');
                  } else if (query.length < 7 ||
                      !RegExp(r'^R\d{6}$').hasMatch(query)) {
                    showToast(
                        message: 'يرجى إدخال رقم اشتراك صحيح مثل R123456');
                  } else {
                    searchSubscription(query);
                  }
                },
              ),
            ),
          ),

          // Results List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredSubscriptions.length,
              itemBuilder: (context, index) {
                final sub = _filteredSubscriptions[index];
                return SubscriptionCard(
                  info: sub,
                  onRequestSubscription: () async {
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    final userId = userProvider.uid; // معرف المستخدم
                    if (userId == null) {
                      showToast(message: 'يرجى تسجيل الدخول أولاً');
                      return;
                    }
                    // تحقق من أن driverId ليس فارغًا أو null
                    if (sub.driver.isEmpty ||
                        sub.driver == 'غير معروف' ||
                        sub.status == 'منتهي') {
                      showToast(
                          message:
                              'لايوجد سائق او الاشتراك منتهي، لا يمكن إرسال الطلب');
                      return;
                    }
                    String homeLocation = '';
                    await showDialog(
                      context: context,
                      builder: (context) {
                        final TextEditingController _homeLocationController =
                            TextEditingController();
                        return AlertDialog(
                          title: Text("ارفاق موقع المنزل"),
                          content: TextField(
                            controller: _homeLocationController,
                            decoration: InputDecoration(
                              hintText: 'ادخل موقع المنزل',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("إلغاء"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                homeLocation = _homeLocationController.text;
                                Navigator.of(context).pop();
                              },
                              child: Text("تأكيد"),
                            ),
                          ],
                        );
                      },
                    );
                    if (homeLocation.isNotEmpty) {
                      await SendByNum_Sub(context, sub.id, userId,
                          homeLocation); // تم إصلاح الخطأ هنا
                      showToast(message: 'تم إرسال طلب الاشتراك بنجاح');
                    } else {
                      showToast(message: 'يرجى إدخال موقع المنزل');
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionInfo {
  final String id;
  final String type;
  final String route;
  //final String pickup;
  final String dropoff;
  final String schedule;
  final String price;
  final String driver;
  final String status;
  final String phone;

  SubscriptionInfo({
    required this.id,
    required this.type,
    required this.route,
    //  required this.pickup,
    required this.dropoff,
    required this.schedule,
    required this.price,
    required this.driver,
    required this.status,
    required this.phone,
  });
}

class SubscriptionCard extends StatelessWidget {
  final SubscriptionInfo info;
  final VoidCallback onRequestSubscription;
  final Color primaryColor = const Color(0xFFFFB300);
  final Color secondaryColor = const Color(0xFF76CB54);

  const SubscriptionCard({
    Key? key,
    required this.info,
    required this.onRequestSubscription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with subscription info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Subscription Type
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      info.type,
                      style: GoogleFonts.tajawal(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  // Subscription Number
                  Text(
                    '#${info.id}',
                    style: GoogleFonts.tajawal(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Route Information
              _buildInfoRow('المسار', info.route, Icons.alt_route),
              _buildInfoRow('نقطة الوصول', info.dropoff, Icons.location_on),

              const Divider(height: 24, thickness: 1),

              // Schedule Information
              _buildSectionTitle('الجدول الزمني'),
              _buildScheduleDetails(info.schedule),

              const Divider(height: 24, thickness: 1),

              // Price and Driver
              Row(
                children: [
                  _buildInfoBox('السعر', info.price, Icons.attach_money),
                  const SizedBox(width: 12),
                  _buildInfoBox('السائق', info.driver, Icons.person),
                ],
              ),

              if (info.status.isNotEmpty && info.status != 'غير معروف') ...[
                const SizedBox(height: 12),
                _buildInfoBox('حالة الاشتراك', info.status, Icons.info),
              ],

              const SizedBox(height: 16),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onRequestSubscription,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'طلب اشتراك',
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.tajawal(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleDetails(String schedule) {
    // تحسين عرض الجدول الزمني مع دعم التنسيقات المختلفة
    final parts = schedule.split('-').map((e) => e.trim()).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (parts.length > 1)
          ...parts
              .map((part) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.circle, size: 8, color: primaryColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            part,
                            style: GoogleFonts.tajawal(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList()
        else
          Text(
            schedule,
            style: GoogleFonts.tajawal(fontSize: 14),
          ),
      ],
    );
  }

  Widget _buildInfoBox(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: primaryColor),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.tajawal(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDetailRow(String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, size: 16, color: Colors.grey),
      ],
    ),
  );
}
