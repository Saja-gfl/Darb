import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/services/FireStore.dart';
import 'package:rem_s_appliceation9/services/rating.dart';
import 'package:provider/provider.dart';
import '../services/UserProvider.dart';

class ReviewPage extends StatefulWidget {
  //جلب ID من الفايرستور
  final String driverId;

  ReviewPage({required this.driverId});
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final Color primaryColor = Color(0xFFFFB300);
  final Color secondaryColor = Color(0xFF76CB54);
  final Color backgroundColor = Colors.white;
  final Color textColor = Colors.black;
  final double borderRadius = 12.0;

  int _rating = 0;
  final Set<String> _selectedTags = {};
  String driverName = "السائق"; // اسم افتراضي
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDriverName(); // جلب اسم السائق عند تحميل الصفحة
  }

  Future<void> _fetchDriverName() async {
    try {
      final name = await FirestoreService().getUserOrDriverName(widget.driverId , true);
      setState(() {
        driverName = name ??
            "السائق"; // إذا لم يتم العثور على الاسم، استخدم الاسم الافتراضي
        isLoading = false;
      });
    } catch (e) {
      print("خطأ أثناء جلب اسم السائق: $e");
      setState(() {
        isLoading = false;
      });
    }
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
          isLoading ? "جاري التحميل..." : driverName,
          style: GoogleFonts.tajawal(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                image:
                                    NetworkImage("https://placehold.co/64x64"),
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
                                  driverName,
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

                          // Star Rating - Now interactive
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _rating = index + 1;
                                  });
                                },
                                child: Icon(
                                  Icons.star,
                                  size: 40,
                                  color: index < _rating
                                      ? primaryColor
                                      : Colors.grey[300],
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 24),

                          // Rating Tags - Now selectable
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
                      onPressed: () async {
                        if (_rating == 0) {
                          // تأكد من أن المستخدم قد اختار تقييمًا
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('يرجى اختيار تقييم قبل الإرسال')),
                          );
                          return;
                        }

                        if (widget.driverId.isEmpty) {
                          // تحقق من وجود driverId
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'رقم السائق غير محدد لا يمكن إرسال التقييم')),
                          );
                          return;
                        }

                        try {
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          await RatingService().addRating(
                            userId: userProvider.uid!,
                            driverId: userProvider.driverId!,
                            rating: _rating,
                            comment: '', // يمكن تعديل هذا لإضافة التعليقات
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('تم إرسال التقييم بنجاح')),
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          print("خطأ أثناء إضافة التقييم: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('حدث خطأ أثناء إرسال التقييم')),
                          );
                        }
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
    final bool isSelected = _selectedTags.contains(text);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedTags.remove(text);
          } else {
            _selectedTags.add(text);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.2) : Colors.grey[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey[300]!,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.tajawal(
            color: isSelected ? primaryColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
