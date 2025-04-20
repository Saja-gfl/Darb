import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionNumberPage extends StatefulWidget {
  const SubscriptionNumberPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionNumberPage> createState() => _SubscriptionNumberPageState();
}

class _SubscriptionNumberPageState extends State<SubscriptionNumberPage> {
  final TextEditingController _searchController = TextEditingController();
  List<SubscriptionInfo> _filteredSubscriptions = [];
  final List<SubscriptionInfo> _allSubscriptions = [
    SubscriptionInfo(
      id: '12345',
      type: 'شهري',
      route: 'عنيزة -> بريدة',
      pickup: 'ميدان الملك فهد',
      dropoff: 'جامعة القصيم',
      schedule: '7:00 صباحاً - الأحد إلى الخميس',
      price: '500 ريال/شهرياً',
      driver: 'محمد أحمد',
      status: 'متاح',
      phone: '0551234567',
    ),
    SubscriptionInfo(
      id: '67890',
      type: 'أسبوعي',
      route: 'الرياض -> الدمام',
      pickup: 'حي النخيل',
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
    _searchController.addListener(_filterSubscriptions);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSubscriptions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSubscriptions = _allSubscriptions.where((sub) {
        return sub.id.toLowerCase().contains(query) ||
            sub.route.toLowerCase().contains(query) ||
            sub.driver.toLowerCase().contains(query);
      }).toList();
    });
  }

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
                  hintText: 'ابحث برقم الاشتراك أو المسار أو السائق...',
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
                  onMessage: () => _messageDriver(sub.phone),
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
  final String pickup;
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
    required this.pickup,
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
  final VoidCallback onMessage;

  const SubscriptionCard({
    Key? key,
    required this.info,
    required this.onMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Subscription Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    info.type,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  'اشتراك #${info.id}',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Route Information
            _buildInfoRow(info.route, Icons.arrow_forward),
            _buildInfoRow(info.pickup, Icons.location_on),
            _buildInfoRow(info.dropoff, Icons.location_on),

            const Divider(height: 24),

            // Schedule and Price
            _buildDetailRow(info.schedule, Icons.access_time),
            _buildDetailRow(info.price, Icons.attach_money),
            _buildDetailRow('السائق: ${info.driver}', Icons.person),

            const Divider(height: 24),

            // Action Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFB300),
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onMessage,
              child: Text(
                'مراسلة السائق',
                style: GoogleFonts.inter(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
          Icon(icon, size: 16, color: const Color(0xFFFFB300)),
        ],
      ),
    );
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
}
