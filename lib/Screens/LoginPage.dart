import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/image_constant.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/routes/app_routes.dart';
import 'package:rem_s_appliceation9/theme/app_decoration.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'package:rem_s_appliceation9/widgets/custom_image_view.dart';
import '../widgets/custom_checkbox_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth.dart';
import '../core/utils/show_toast.dart';
import 'package:provider/provider.dart';
import '../services/UserProvider.dart';

// ignore_for_file: must_be_immutable
class K0Screen extends StatefulWidget {
  @override
  _K0ScreenState createState() => _K0ScreenState();
}

class _K0ScreenState extends State<K0Screen> {
  final FirebaseAuthServises _auth = FirebaseAuthServises();

  TextEditingController usernameInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();

  bool tf = false;
  bool _isSigning = false;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    _setupNotifications();

    // استدعاء الدالة للتحقق من حالة تسجيل الدخول بعد بناء الـ Widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginStatus();
    });
  }

  void _setupNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // ✅ يعمل تلقائي على Android
    NotificationSettings settings = await messaging.requestPermission();

    print('🔔 Android permission status: ${settings.authorizationStatus}');

    // عند استقبال إشعار والتطبيق مفتوح
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📩 Foreground: ${message.notification?.title}');
    });

    // عند فتح التطبيق من خلال إشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🚀 Opened from notification: ${message.notification?.title}');
    });
  }

  @override
  void dispose() {
    usernameInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: theme.colorScheme.onPrimaryContainer,
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              left: 36.h,
              top: 94.h,
              right: 36.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.img5935976241859510486,
                  height: 122.h,
                  width: 182.h,
                  margin: EdgeInsets.only(left: 70.h),
                ),
                SizedBox(height: 38.h),
                _buildUserLoginForm(context)
              ],
            ),
          ),
        ));
  }

  /// Section Widget
  Widget _buildUserLoginForm(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 22.h,
        vertical: 12.h,
      ),
      decoration: AppDecoration.outlineBlueGray?.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ) ??
          BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "البريد الالكتروني:",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextFormField(
            controller: usernameInputController,
            hintText: "ادخل البريد الالكتروني",
            contentPadding: EdgeInsets.fromLTRB(12.h, 10.h, 12.h, 6.h),
            textStyle: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 24.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "كلمة السر:",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextFormField(
            controller: passwordInputController,
            hintText: "أدخل كلمة السر هنا",
            textInputAction: TextInputAction.done,
            contentPadding: EdgeInsets.fromLTRB(12.h, 10.h, 12.h, 6.h),
            textStyle: TextStyle(color: Colors.black),
            obscureText: hidePassword,
          ),
          SizedBox(height: 26.h),
          CustomCheckboxButton(
            text: "عرض كلمة المرور",
            value: !hidePassword,
            onChange: (value) {
              setState(() {
                hidePassword = !value;
              });
            },
          ),
          SizedBox(height: 44.h),
          CustomElevatedButton(
              text: "تسجيل دخول",
              onPressed: () {
                _login();
              }),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () {
              onTapTxttf(context);
            },
            child: Text(
              "ليس لديك حساب؟ سجل",
              style: theme.textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the k1Screen when the action is triggered.
  onTapTxttf(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.k1Screen);
  }

  void _login() async {
    setState(() {
      _isSigning = true;
    });

    String email = usernameInputController.text;
    String password = passwordInputController.text;

    try {
      // استدعاء دالة تسجيل الدخول من FirebaseAuthServises
      User? user = await _auth.login(email, password);

      if (user != null) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.loadUserData(user.uid);

        // جلب fcmToken
        String? fcmToken = await FirebaseMessaging.instance.getToken();

        if (fcmToken != null) {
          // تحديث أو إضافة fcmToken في Firestore
          final userDocRef = FirebaseFirestore.instance
              .collection(userProvider.isDriver ? 'driverdata' : 'userdata')
              .doc(user.uid);

          final userDoc = await userDocRef.get();

          if (userDoc.exists) {
            // إذا كان المستند موجودًا، قم بتحديث fcmToken
            await userDocRef.update({
              'fcmToken': fcmToken,
            });
            print("✅ تم تحديث fcmToken بنجاح.");
          } else {
            // إذا لم يكن المستند موجودًا، قم بإنشائه مع fcmToken
            await userDocRef.set({
              'fcmToken': fcmToken,
              'email': email,
              'createdAt': FieldValue.serverTimestamp(),
            });
            print("✅ تم إنشاء مستند جديد مع fcmToken.");
          }
        } else {
          print("❌ لم يتم الحصول على fcmToken.");
        }

        // عرض رسالة نجاح
        showToast(message: "تم تسجيل الدخول بنجاح");

        // الانتقال إلى الصفحة الرئيسية بناءً على نوع المستخدم
        Navigator.pushReplacementNamed(
          context,
          userProvider.isDriver
              ? AppRoutes.driverHomePage
              : AppRoutes.userHomePage,
        );
      } else {
        showToast(message: "تعذر تسجيل الدخول. يرجى المحاولة لاحقًا.");
      }
    } on FirebaseAuthException catch (e) {
      // معالجة الأخطاء الخاصة بـ FirebaseAuth
      switch (e.code) {
        case 'user-not-found':
          showToast(
              message: "المستخدم غير موجود. يرجى التحقق من البريد الإلكتروني.");
          break;
        case 'wrong-password':
          showToast(message: "كلمة المرور غير صحيحة. يرجى المحاولة مرة أخرى.");
          break;
        case 'invalid-email':
          showToast(message: "صيغة البريد الإلكتروني غير صحيحة.");
          break;
        default:
          showToast(message: "حدث خطأ أثناء تسجيل الدخول: ${e.message}");
      }
    } catch (e) {
      // معالجة الأخطاء العامة
      showToast(message: "حدث خطأ غير متوقع: ${e.toString()}");
      print(e.toString());
    } finally {
      setState(() {
        _isSigning = false;
      });
    }
  }

  void _updateUserProvider(User user, Map<String, dynamic> userData) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.setUid(user.uid);
    userProvider.setEmail(user.email ?? '');
    userProvider.setUserName(userData['name'] ?? '');
    userProvider.setPhoneNumber(userData['phone'] ?? '');
    userProvider.setLocation(userData['address'] ?? '');
    userProvider.setIsDriver(userData['isDriver'] ?? false);
    userProvider.setTripId(userData['tripId'] ?? '');
    userProvider.setGender(userData['Gender'] ?? '');
    userProvider.setCarType(userData['carType'] ?? '');
    userProvider.setPlateNumber(userData['plateNumber'] ?? '');
  }

  Future<void> _checkLoginStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // هنا ستقوم بتخزين الـ UID في Provider بعد التحقق من حالة المستخدم
      Provider.of<UserProvider>(context, listen: false).setUid(user.uid);
    }
  }
}

// تعريف الـ CustomElevatedButton مع required parameters
class CustomElevatedButton extends StatelessWidget {
  final String text; // required text parameter
  final VoidCallback onPressed; // required onPressed callback

  // constructor with required parameters
  CustomElevatedButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.orange, // يمكنك تغيير اللون أو إضافة المزيد من الخصائص
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text, // تمرير النص هنا
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
