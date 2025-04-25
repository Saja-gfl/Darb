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
    this.primaryColor = const Color(0xFFFFB300), // Orange color
    this.secondaryColor = const Color(0xFF76CB54),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Split the schedule string into individual days
    List<String> scheduleDays =
        schedule.split(',').map((day) => day.trim()).toList();

    return Container(
      padding: const EdgeInsets.all(16),
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
          // Header with subscription number and type
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
                    Icon(Icons.category,
                        size: 16, color: primaryColor), // Orange icon
                    const SizedBox(width: 6),
                    Text(
                      type,
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
                    '#$subscriptionNumber',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.confirmation_number_outlined,
                      size: 20, color: primaryColor), // Orange icon
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Customer Name
          _buildInfoRow(Icons.person_outline, customerName),
          const SizedBox(height: 10),

          // Route
          _buildInfoRow(Icons.route_outlined, route),
          const SizedBox(height: 10),

          // Pickup
          _buildInfoRow(Icons.location_on_outlined, pickup),
          const SizedBox(height: 10),

          // Dropoff
          _buildInfoRow(Icons.flag_outlined, dropoff),
          const SizedBox(height: 10),

          // Schedule - Modified to show days line by line
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: scheduleDays
                    .map((day) => Text(
                          day,
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(width: 10),
              Icon(Icons.access_time_outlined, size: 20, color: primaryColor),
            ],
          ),
          const SizedBox(height: 10),

          // Price
          _buildInfoRow(Icons.attach_money_outlined, price),
          const SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onReject,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.red.shade300, width: 1),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close, size: 18),
                      SizedBox(width: 8),
                      Text('رفض'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, size: 18),
                      SizedBox(width: 8),
                      Text('قبول'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, size: 20, color: primaryColor), // All icons in orange
      ],
    );
  }
}
