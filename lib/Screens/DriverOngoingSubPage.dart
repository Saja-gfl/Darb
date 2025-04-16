import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverOngoingSubPage extends StatefulWidget {
  const DriverOngoingSubPage({Key? key}) : super(key: key);

  @override
  _DriverOngoingSubPageState createState() => _DriverOngoingSubPageState();
}

class _DriverOngoingSubPageState extends State<DriverOngoingSubPage> {
  final Color primaryColor = const Color(0xFFFFB300);
  final Color secondaryColor = const Color(0xFF76CB54);
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _selectedTab = 'الكل';
  bool _isRefreshing = false;

  // Mock data
  final List<Map<String, dynamic>> _allSubscriptions = [
    {
      'id': '12345',
      'type': 'شهري',
      'customerName': 'مرام المطيري',
      'customerPhone': '0551234567',
      'route': 'عنيزة → بريدة',
      'pickupLocation': 'نقطة الانطلاق الرئيسية',
      'dropoffLocation': 'موقع العمل',
      'pickupTime': '7:00 صباحاً',
      'days': ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'],
      'price': 500,
      'status': 'active',
      'startDate': '01/10/2023',
      'endDate': '31/10/2023',
    },
    {
      'id': '12346',
      'type': 'أسبوعي',
      'customerName': 'علي أحمد',
      'customerPhone': '0557654321',
      'route': 'البكيرية → بريدة',
      'pickupLocation': 'المنزل',
      'dropoffLocation': 'الجامعة',
      'pickupTime': '8:00 صباحاً',
      'days': ['الأحد', 'الثلاثاء', 'الخميس'],
      'price': 300,
      'status': 'active',
      'startDate': '01/10/2023',
      'endDate': '07/10/2023',
    },
    {
      'id': '12347',
      'type': 'يومي',
      'customerName': 'سارة خالد',
      'customerPhone': '0559876543',
      'route': 'المذنب → بريدة',
      'pickupLocation': 'الحي الشمالي',
      'dropoffLocation': 'المستشفى',
      'pickupTime': '6:30 صباحاً',
      'days': ['يومياً'],
      'price': 50,
      'status': 'pending',
      'startDate': '01/10/2023',
      'endDate': '01/10/2023',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() => _searchQuery = _searchController.text);
  }

  List<Map<String, dynamic>> get _filteredSubscriptions {
    return _allSubscriptions.where((sub) {
      final matchesSearch = _searchQuery.isEmpty ||
          sub['customerName'].toString().contains(_searchQuery) ||
          sub['route'].toString().contains(_searchQuery) ||
          sub['id'].toString().contains(_searchQuery);

      final matchesTab = _selectedTab == 'الكل' ||
          sub['type'] == _selectedTab ||
          (_selectedTab == 'غير منتهي' && sub['status'] != 'ended');

      return matchesSearch && matchesTab;
    }).toList();
  }

  Future<void> _refreshSubscriptions() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate refresh
    setState(() => _isRefreshing = false);
  }

  void _endSubscription(String subscriptionId) {
    setState(() {
      final index =
          _allSubscriptions.indexWhere((sub) => sub['id'] == subscriptionId);
      if (index != -1) {
        _allSubscriptions[index]['status'] = 'ended';
      }
    });
    _showRatingDialog(subscriptionId);
  }

  void _showRatingDialog(String subscriptionId) {
    showDialog(
      context: context,
      builder: (context) => RatingDialog(
        onRatingSubmitted: (rating, comment) {
          _handleRatingSubmission(subscriptionId, rating, comment);
        },
      ),
    );
  }

  void _handleRatingSubmission(
      String subscriptionId, int rating, String comment) {
    // In a real app, you would save this to your database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم إرسال التقييم بنجاح ($rating نجوم)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'اشتراكاتي النشطة',
          style: GoogleFonts.tajawal(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: primaryColor),
            onPressed: _refreshSubscriptions,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshSubscriptions,
        color: primaryColor,
        child: Column(
          children: [
            // Search and Filter Row
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildSearchFilterRow(),
            ),

            // Subscription Type Tabs
            _buildSubscriptionTabs(),

            // Subscription Cards List
            Expanded(
              child: _filteredSubscriptions.isEmpty
                  ? Center(
                      child: Text(
                        'لا توجد اشتراكات',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: _filteredSubscriptions.length,
                      itemBuilder: (context, index) {
                        final subscription = _filteredSubscriptions[index];
                        return _buildSubscriptionCard(subscription);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchFilterRow() {
    return Row(
      children: [
        // Filter Button
        Expanded(
          child: OutlinedButton(
            onPressed: _showAdvancedFilter,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.filter_list, size: 20, color: primaryColor),
                const SizedBox(width: 8),
                Text(
                  'تصفية',
                  style: GoogleFonts.tajawal(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Search Field
        Expanded(
          flex: 2,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'ابحث عن اشتراك...',
              hintStyle: GoogleFonts.tajawal(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: primaryColor),
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionTabs() {
    final tabs = ['الكل', 'شهري', 'أسبوعي', 'يومي', 'غير منتهي'];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final isSelected = _selectedTab == tab;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () => setState(() => _selectedTab = tab),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(Map<String, dynamic> subscription) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                    subscription['type'],
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Text(
                  'اشتراك #${subscription['id']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('اسم العميل', subscription['customerName']),
            _buildInfoRow('رقم الهاتف', subscription['customerPhone']),
            _buildInfoRow('المسار', subscription['route']),
            _buildInfoRow('نقطة الانطلاق', subscription['pickupLocation']),
            _buildInfoRow('نقطة التوصيل', subscription['dropoffLocation']),
            _buildInfoRow('المواعيد', _buildScheduleText(subscription)),
            _buildInfoRow('السعر', '${subscription['price']} ريال'),
            _buildInfoRow('الحالة', _getStatusText(subscription['status'])),
            _buildInfoRow('تاريخ البدء', subscription['startDate']),
            _buildInfoRow('تاريخ الانتهاء', subscription['endDate']),
            const SizedBox(height: 16),
            if (subscription['status'] == 'active')
              ElevatedButton(
                onPressed: () => _endSubscription(subscription['id']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('إنهاء الاشتراك'),
              ),
            if (subscription['status'] == 'pending')
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _rejectSubscription(subscription['id']),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        minimumSize: const Size(0, 50),
                      ),
                      child: const Text('رفض',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _acceptSubscription(subscription['id']),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        minimumSize: const Size(0, 50),
                      ),
                      child: const Text('قبول'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  String _buildScheduleText(Map<String, dynamic> subscription) {
    if (subscription['type'] == 'يومي') {
      return '${subscription['pickupTime']} - يومياً';
    } else {
      return '${subscription['pickupTime']} - ${subscription['days'].join('، ')}';
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'نشط';
      case 'pending':
        return 'معلق';
      case 'ended':
        return 'منتهي';
      case 'rejected':
        return 'مرفوض';
      default:
        return status;
    }
  }

  void _showAdvancedFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'خيارات التصفية المتقدمة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildFilterOption(
                  'عرض الاشتراكات النشطة فقط', Icons.check_circle),
              _buildFilterOption('عرض الاشتراكات المعلقة', Icons.pending),
              _buildFilterOption('عرض الاشتراكات المنتهية', Icons.done_all),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('تطبيق التصفية'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title, textAlign: TextAlign.right),
      trailing: Checkbox(
        value: false,
        onChanged: (value) {},
        activeColor: primaryColor,
      ),
    );
  }

  void _acceptSubscription(String subscriptionId) {
    setState(() {
      final index =
          _allSubscriptions.indexWhere((sub) => sub['id'] == subscriptionId);
      if (index != -1) {
        _allSubscriptions[index]['status'] = 'active';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم قبول الاشتراك بنجاح')),
    );
  }

  void _rejectSubscription(String subscriptionId) {
    setState(() {
      final index =
          _allSubscriptions.indexWhere((sub) => sub['id'] == subscriptionId);
      if (index != -1) {
        _allSubscriptions[index]['status'] = 'rejected';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم رفض الاشتراك بنجاح')),
    );
  }
}

class RatingDialog extends StatefulWidget {
  final Function(int, String) onRatingSubmitted;

  const RatingDialog({Key? key, required this.onRatingSubmitted})
      : super(key: key);

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 5;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('قيم العميل', textAlign: TextAlign.right),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('كم نجمة تعطي لهذا العميل؟', textAlign: TextAlign.right),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 30,
                ),
                onPressed: () => setState(() => _rating = index + 1),
              );
            }),
          ),
          const SizedBox(height: 20),
          const Text('اكتب تعليقاً (اختياري)', textAlign: TextAlign.right),
          TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onRatingSubmitted(_rating, _commentController.text);
            Navigator.pop(context);
          },
          child: const Text('إرسال التقييم'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
