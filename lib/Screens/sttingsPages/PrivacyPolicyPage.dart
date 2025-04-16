import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("سياسة الخصوصية", style: TextStyle(color: Color(0xFFFFB300))),
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
            _buildPolicySection("مقدمة",
                "نحن في تطبيق درب نحرص على خصوصية مستخدمينا. هذه السياسة توضح كيف نجمع ونستخدم المعلومات الشخصية."),
            _buildPolicySection("المعلومات التي نجمعها",
                "- المعلومات الأساسية (الاسم، البريد الإلكتروني، رقم الجوال)\n- معلومات الموقع عند الحاجة للخدمة\n- بيانات الاستخدام والتقارير الفنية"),
            _buildPolicySection("كيف نستخدم المعلومات",
                "- تقديم وتحسين الخدمات\n- التواصل مع المستخدمين\n- الأمان ومنع الاحتيال\n- التحليلات والبحوث"),
            _buildPolicySection("حماية المعلومات",
                "نستخدم معايير أمنية صناعية لحماية بياناتك. ومع ذلك، لا يمكن ضمان أمان كامل لأي طريقة نقل عبر الإنترنت."),
            _buildPolicySection("التغييرات على السياسة",
                "قد نحدث هذه السياسة بين الحين والآخر. سننشر أي تغييرات على هذه الصفحة ونخطر المستخدمين إذا كانت التغييرات جوهرية."),
            SizedBox(height: 24.h),
            Text(
                "لأية استفسارات حول الخصوصية، يرجى التواصل عبر: privacy@rem-s.com",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.h)),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, String content) {
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
