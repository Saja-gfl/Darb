import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DriverOngoingSubCard extends StatefulWidget {
  final Map<String, dynamic> subscription;
  final Color primaryColor;
  final Function(String) onEndSubscription;

  const DriverOngoingSubCard({
    Key? key,
    required this.subscription,
    required this.primaryColor,
    required this.onEndSubscription,
  }) : super(key: key);

  @override
  _DriverOngoingSubCardState createState() => _DriverOngoingSubCardState();
}

class _DriverOngoingSubCardState extends State<DriverOngoingSubCard> {
  bool _showEndButton = true;

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

String _buildScheduleText(Map<String, dynamic> subscription) {
  final pickupTime = subscription['schedule'] ?? 'غير معروف';
  final days = subscription['days'] ?? [];

  if (subscription['type'] == 'اسبوعي' || subscription['type'] == 'شهري') {
    return '$pickupTime - يومياً';
  } else {
    return '$pickupTime - ${days.join('، ')}';
  }
}




  void _handleEndSubscription() {
    setState(() {
      _showEndButton = false;
    });
    widget.onEndSubscription(widget.subscription['tripId'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
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
                    widget.subscription['type'],
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Text(
                  'اشتراك #${widget.subscription['tripId'] ?? ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.person, widget.subscription['userName'] ?? ''),
            _buildInfoRow(Icons.phone, widget.subscription['userphone'] ?? ''),
_buildInfoRow(
  Icons.route,
  '${widget.subscription['fromLocation']} إلى ${widget.subscription['toLocation']}',
),
            _buildInfoRow(
                Icons.location_on, widget.subscription['homeLocation'] ?? 'غير محدد'),
            _buildInfoRow(
                Icons.location_off, widget.subscription['workLocation'] ?? 'غير محدد'),
            _buildInfoRow(
                Icons.schedule, _buildScheduleText(widget.subscription )),
            _buildInfoRow(
                Icons.attach_money, '${widget.subscription['price']} ريال'),
            _buildInfoRow(
                Icons.info, _getStatusText(widget.subscription['status'] ?? '')),
                              //القيم من نوع تايم ستامب في الفايرستور فا لازم اعدل هنا 
_buildInfoRow(
  Icons.calendar_today,
  widget.subscription['startDate'] != null && widget.subscription['startDate'] is Timestamp
      ? DateFormat.yMd('ar_SA').format(widget.subscription['startDate'].toDate())
      : 'غير معروف',
),
_buildInfoRow(
  Icons.calendar_today,
  widget.subscription['endDate'] != null && widget.subscription['endDate'] is Timestamp
      ? DateFormat.yMd('ar_SA').format(widget.subscription['endDate'].toDate())
      : 'غير معروف',
),

            const SizedBox(height: 16),
            if (_showEndButton && widget.subscription['status'] == 'نشط')
              ElevatedButton(
                onPressed: _handleEndSubscription,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('إنهاء الاشتراك'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String value) {
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
          Icon(
            icon,
            color: widget.primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}
