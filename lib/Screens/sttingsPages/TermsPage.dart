import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("شروط الخدمة", style: TextStyle(color: Color(0xFFFFB300))),
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
            Text("آخر تحديث: ١ يناير ٢٠٢٣",
                style: TextStyle(fontSize: 14.h, color: Colors.grey)),
            SizedBox(height: 24.h),
            _buildTermSection("القبول بالشروط",
                "باستخدامك تطبيق درب، فإنك توافق على الالتزام بهذه الشروط والأحكام."),
            _buildTermSection("الاشتراكات والدفع",
                "- الدفع يتم مقدماً عبر الوسائل المتاحة\n- يمكن إلغاء الاشتراك قبل 24 ساعة من الموعد\n- لا استرداد للأموال بعد بدء الخدمة"),
            _buildTermSection("سلوك المستخدم",
                "يجب على المستخدمين:\n- تقديم معلومات دقيقة\n- عدم إساءة استخدام الخدمة\n- احترام مواعيد الاشتراكات"),
            _buildTermSection("إلغاء الخدمة",
                "يحق للتطبيق تعليق أو إنهاء الخدمة لأي مستخدم يخالف هذه الشروط بدون سابق إنذار."),
            _buildTermSection("المسؤولية",
                "التطبيق غير مسؤول عن:\n- التأخير الناتج عن ظروف خارجة عن إرادتنا\n- الأضرار الناتجة عن سوء استخدام المستخدم للخدمة"),
            SizedBox(height: 24.h),
            Text(
                "لأية استفسارات حول الشروط والأحكام، يرجى التواصل عبر: legal@rem-s.com",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.h)),
          ],
        ),
      ),
    );
  }

  Widget _buildTermSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 16.h),
        Text(title,
            style: TextStyle(
              fontSize: 18.h,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            )),
        SizedBox(height: 8.h),
        Text(content,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16.h,
              height: 1.5,
            )),
      ],
    );
  }
}
