import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("المساعدة والدعم", style: TextStyle(color: Color(0xFFFFB300))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFB300)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildSection("الأسئلة الشائعة", [
              _buildFAQItem("كيف يمكنني حجز اشتراك؟",
                  "اضغط على زر 'إنشاء اشتراك جديد' في الصفحة الرئيسية واتبع الخطوات لاختيار السائق والتوقيت المناسب"),
              _buildFAQItem("كيف أتتبع اشتراكاتي؟",
                  "يمكنك مشاهدة جميع اشتراكاتك الجارية في قسم 'الاشتراكات الجارية' في الصفحة الرئيسية"),
              _buildFAQItem("كيف أتواصل مع السائق؟",
                  "يمكنك استخدام خاصية المحادثة في التطبيق للتواصل مباشرة مع السائق"),
            ]),
            SizedBox(height: 24.h),
            _buildSection("الدعم الفني", [
              Text("للاستفسارات الفنية أو المشاكل التقنية:",
                  style: TextStyle(fontSize: 16.h)),
              SizedBox(height: 8.h),
              _buildContactItem(Icons.phone, "920000000"),
              _buildContactItem(Icons.email, "support@rem-s.com"),
              _buildContactItem(Icons.access_time,
                  "من الأحد إلى الخميس، 8 صباحًا إلى 5 مساءً"),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title,
            style: TextStyle(
              fontSize: 20.h,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            )),
        SizedBox(height: 12.h),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.h),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(question,
              style: TextStyle(
                fontSize: 16.h,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              )),
          SizedBox(height: 4.h),
          Text(answer,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.h,
                color: Colors.grey[700],
              )),
          Divider(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(text, style: TextStyle(fontSize: 16.h)),
          SizedBox(width: 8.h),
          Icon(icon, color: theme.colorScheme.primary),
        ],
      ),
    );
  }
}
