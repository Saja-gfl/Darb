import 'package:flutter/material.dart';

class RequestedsubCard extends StatefulWidget {
  final Map<String, dynamic> subscription;
  final Function(String) onCancel;
  final Color primaryColor;
  final Color secondaryColor;

  const RequestedsubCard({
    Key? key,
    required this.subscription,
    required this.onCancel,
    this.primaryColor = const Color(0xFFFFB300),
    this.secondaryColor = const Color(0xFF76CB54),
  }) : super(key: key);

  @override
  _RequestedsubCardState createState() => _RequestedsubCardState();
}

class _RequestedsubCardState extends State<RequestedsubCard> {
  bool _isCancelled = false;

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'معلق':
        return Colors.orange;
      case 'مرفوض':
        return Colors.red;
      case 'مقبول':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Future<void> _handleCancel() async {
    final shouldCancel = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الإلغاء'),
        content: const Text('هل أنت متأكد أنك تريد إلغاء هذا الاشتراك؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('تراجع'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('تأكيد', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (shouldCancel == true) {
      setState(() {
        _isCancelled = true;
      });
      widget.onCancel(widget.subscription['tripId']);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isCancelled) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.category, size: 16, color: widget.primaryColor),
                    const SizedBox(width: 6),
                    Text(
                      widget.subscription['type'] ?? 'غير محدد',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    '#${widget.subscription['tripId']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.confirmation_number_outlined,
                      size: 20, color: widget.primaryColor),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Route Information
          _buildInfoRow(Icons.route_outlined,
              '${widget.subscription['fromLocation']} → ${widget.subscription['toLocation']}'),
          const SizedBox(height: 10),
          _buildInfoRow(Icons.location_on_outlined,
              ' ${widget.subscription['homeLocation']} :نقطة الانطلاق: '),
          const SizedBox(height: 10),
          _buildInfoRow(Icons.flag_outlined,
              ' ${widget.subscription['workLocation']} :نقطة التوصيل'),
          const SizedBox(height: 10),

          // Driver Information
          if (widget.subscription['driverData'] != null) ...[
            _buildInfoRow(Icons.person_outlined,
                ' ${widget.subscription['driverData']['name']}: السائق '),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.directions_car_outlined,
                ' ${widget.subscription['driverData']['carType']} :نوع السيارة: '),
            const SizedBox(height: 10),
           // _buildInfoRow(Icons.phone_outlined,
           //     'رقم الجوال: ${widget.subscription['driverData']['phone']}'),
            //const SizedBox(height: 10),
          ],

          // Schedule and Price - FIXED: Added Flexible to prevent overflow
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  ' ${widget.subscription['schedule'] ?? 'غير محدد'} : المواعيد',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.access_time_outlined,
                  size: 20, color: widget.primaryColor),
            ],
          ),
          const SizedBox(height: 10),

          _buildInfoRow(Icons.attach_money_outlined,
              'ريال${widget.subscription['price']} :السعر'),
          const SizedBox(height: 20),

          // Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor(widget.subscription['sub_status']),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.subscription['sub_status'] ?? 'غير محدد',
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Cancel Button
          ElevatedButton(
            onPressed: _handleCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.red.shade300, width: 1),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.close, size: 18),
                SizedBox(width: 8),
                Text('إلغاء الاشتراك'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, size: 20, color: widget.primaryColor),
      ],
    );
  }
}
