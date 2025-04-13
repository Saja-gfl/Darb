import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final String subscriptionNumber;
  final String type;
  final String customerName;
  final String route;
  final String pickup;
  final String dropoff;
  final String schedule;
  final String price;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final Color primaryColor;
  final Color secondaryColor;

  const SubscriptionCard({
    Key? key,
    required this.subscriptionNumber,
    required this.type,
    required this.customerName,
    required this.route,
    required this.pickup,
    required this.dropoff,
    required this.schedule,
    required this.price,
    required this.onAccept,
    required this.onReject,
    this.primaryColor = const Color(0xFFFFB300),
    this.secondaryColor = const Color(0xFF76CB54),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E5E5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Header with subscription number and type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  type,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                'اشتراك #$subscriptionNumber',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Customer Name
          _buildInfoRow('اسم العميل', customerName),
          const SizedBox(height: 8),

          // Route
          _buildInfoRow('المسار', route),
          const SizedBox(height: 8),

          // Pickup
          _buildInfoRow('نقطة الانطلاق', pickup),
          const SizedBox(height: 8),

          // Dropoff
          _buildInfoRow('نقطة التوصيل', dropoff),
          const SizedBox(height: 8),

          // Schedule
          _buildInfoRow('المواعيد', schedule),
          const SizedBox(height: 8),

          // Price
          _buildInfoRow('السعر', price),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onReject,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Colors.grey),
                  ),
                  child: const Text('رفض الاشتراك'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('قبول الاشتراك'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
