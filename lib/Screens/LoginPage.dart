import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/custom_checkbox_button.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
<<<<<<< Updated upstream
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import '../core/utils/show_toast.dart';


=======
>>>>>>> Stashed changes

// ignore_for_file: must_be_immutable
class K0Screen extends StatefulWidget {
  @override
  _K0ScreenState createState() => _K0ScreenState();
}

class _K0ScreenState extends State<K0Screen> {
  final FirebaseAuthServises _auth = FirebaseAuthServises();

  TextEditingController usernameInputController = TextEditingController();

  TextEditingController passwordInputController = TextEditingController();

  bool tf = false;
  bool _isSigning = false;
  @override
  void dispose() {
    usernameInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              margin: EdgeInsets.only(right: 56.h),
            ),
            SizedBox(height: 38.h),
            _buildUserLoginForm(context)
          ],
        ),
      ),
    );
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
) ?? BoxDecoration(
  borderRadius: BorderRadiusStyle.roundedBorder8,
  // Add other default properties if needed
),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "اسم المستخدم:",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextFormField(
            controller: usernameInputController,
            hintText: "ادخل اسم المستخدم",
            contentPadding: EdgeInsets.fromLTRB(12.h, 10.h, 12.h, 6.h),
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
          ),
          SizedBox(height: 26.h),
          CustomCheckboxButton(
            text: "عرض كلمة المرور",
            value: tf,
            onChange: (value) {
              setState(() {
                tf = value;
              });
            },
          ),
          SizedBox(height: 44.h),
          CustomElevatedButton(
            text: "تسجيل دخول",
            onPressed: _login,
          ),
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

    User? user = await _auth.login(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      Navigator.pushNamed(context, "/home");
    } else {
      showToast(message: "some error occured");
    }
  }

}
 
