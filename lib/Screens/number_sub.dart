import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/widgets/subscription_card.dart';
import 'package:rem_s_appliceation9/widgets/custom_text_form_field.dart';

class NumberSubPage extends StatefulWidget {
  @override
  _NumberSubPageState createState() => _NumberSubPageState();
}

class _NumberSubPageState extends State<NumberSubPage> {
  final TextEditingController _subscriptionController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _subscriptionData;

  final Color primaryColor = Color(0xFFFFB300);
  final Color secondaryColor = Color(0xFF76CB54);
  final Color backgroundColor = Colors.white;
  final Color textColor = Colors.black;
  final double borderRadius = 12.0;

  @override
  void dispose() {
    _subscriptionController.dispose();
    super.dispose();
  }

  Future<void> _fetchSubscription() async {
    if (_subscriptionController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _subscriptionData = null;
    });

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 1));

    // Mock database
    final mockDatabase = {
      '12345': {
        'type': 'شهري',
        'route': 'عنيزة → بريدة',
        'pickup': 'الموقع الرئيسي',
        'dropoff': 'موقع العمل',
        'schedule': '7:00 صباحاً - الأحد إلى الخميس',
        'price': '500 ريال/شهرياً',
        'driver': 'أحمد محمد',
        'status': 'نشط',
      },
      '67890': {
        'type': 'يومي',
        'route': 'الرياض → الخرج',
        'pickup': 'الموقع المركزي',
        'dropoff': 'الموقع الفرعي',
        'schedule': '8:00 صباحاً - الأحد إلى الخميس',
        'price': '50 ريال/يومياً',
        'driver': 'خالد علي',
        'status': 'نشط',
      },
    };

    setState(() {
      _subscriptionData = mockDatabase[_subscriptionController.text];
      _isLoading = false;
    });
  }

  void _textDriver() {
    if (_subscriptionData == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('سيتم التواصل مع السائق ${_subscriptionData!['driver']}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'البحث برقم الاشتراك',
          style: GoogleFonts.tajawal(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Solution 1: Using Directionality with TextAlign in TextStyle
            Directionality(
              textDirection: TextDirection.rtl,
              child: CustomTextFormField(
                controller: _subscriptionController,
                hintText: 'أدخل رقم الاشتراك',
                textInputType: TextInputType.number,
                suffix: Icon(Icons.search, color: primaryColor),
                textStyle: GoogleFonts.tajawal().copyWith(
                    // textAlign: TextAlign.right, // This works with Directionality
                    ),
                onTap: _fetchSubscription,
              ),
            ),

            // OR Solution 2: Using textAlign directly in CustomTextFormField (if you modify it)
            /*
            CustomTextFormField(
              controller: _subscriptionController,
              hintText: 'أدخل رقم الاشتراك',
              textInputType: TextInputType.number,
              suffix: Icon(Icons.search, color: primaryColor),
              textAlign: TextAlign.right, // If you add this parameter to your widget
              onTap: _fetchSubscription,
            ),
            */

            SizedBox(height: 16),

            // Search Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _fetchSubscription,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'بحث',
                        style: GoogleFonts.tajawal(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 24),

            // Subscription Card or Not Found Message
            if (_isLoading)
              CircularProgressIndicator(color: primaryColor)
            else if (_subscriptionData != null)
              Expanded(
                child: SingleChildScrollView(
                  child: SubscriptionCard(
                    subscriptionNumber: _subscriptionController.text,
                    type: _subscriptionData!['type'],
                    route: _subscriptionData!['route'],
                    pickup: _subscriptionData!['pickup'],
                    dropoff: _subscriptionData!['dropoff'],
                    schedule: _subscriptionData!['schedule'],
                    price: _subscriptionData!['price'],
                    driver: _subscriptionData!['driver'],
                    status: _subscriptionData!['status'],
                    onSharePressed: () {
                      // Handle share functionality
                    },
                    onRatePressed: () {
                      // Handle rate action
                    },
                  ),
                ),
              )
            else if (_subscriptionController.text.isNotEmpty && !_isLoading)
              Text(
                'لا يوجد اشتراك بهذا الرقم',
                style: GoogleFonts.tajawal(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),

            // Text Driver Button
            if (_subscriptionData != null) ...[
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _textDriver,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                  child: Text(
                    'تواصل مع السائق',
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
