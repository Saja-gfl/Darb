import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFFFFB300);
    final Color secondaryColor = Color(0xFF76CB54);
    final Color backgroundColor = Colors.white;
    final Color textColor = Colors.black;
    final double borderRadius = 12.0;

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
          'تقييم السائق',
          style: GoogleFonts.tajawal(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Driver Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Driver Avatar
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor, width: 2),
                        image: DecorationImage(
                          image: NetworkImage("https://placehold.co/64x64"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),

                    // Driver Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'السائق',
                            style: GoogleFonts.tajawal(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Toyota Camry • ABC 123',
                            style: GoogleFonts.tajawal(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Rating Section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'كيف كان اشتراكك؟',
                      style: GoogleFonts.tajawal(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Star Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          5,
                          (index) => Icon(
                                Icons.star,
                                size: 40,
                                color:
                                    index < 4 ? primaryColor : Colors.grey[300],
                              )),
                    ),
                    SizedBox(height: 24),

                    // Rating Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.end,
                      children: [
                        _buildRatingTag('خدمة ممتازة'),
                        _buildRatingTag('السيارة نظيفة'),
                        _buildRatingTag('بالوقت'),
                        _buildRatingTag('أمن'),
                        _buildRatingTag('مهذب'),
                        _buildRatingTag('قيادة آمنة'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Additional Comments
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'تعليقات إضافية',
                  style: GoogleFonts.tajawal(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'شارك رأيك بتجربتك (اختياري)',
                    hintStyle: GoogleFonts.tajawal(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle review submission
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  elevation: 2,
                  shadowColor: primaryColor.withOpacity(0.3),
                ),
                child: Text(
                  'شارك تقييمك',
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        text,
        style: GoogleFonts.tajawal(),
      ),
    );
  }
}
