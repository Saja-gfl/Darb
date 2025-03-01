import 'dart:developer';

//import 'package:Darb/lib/Screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/utils/show_toast.dart';

// ignore_for_file: must_be_immutable
class K1Screen extends StatefulWidget {
  K1Screen({super.key});
  @override
  K1ScreenState createState() => K1ScreenState();
}

class K1ScreenState extends State<K1Screen> {
  final FirebaseAuthServises _auth = FirebaseAuthServises();
  //final _auth = auth1();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController usernameInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController confirmPasswordInputController =
      TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();
  TextEditingController carTypeInputController =
      TextEditingController(); // New controller for car type
  TextEditingController plateNumberInputController =
      TextEditingController(); // New controller for plate number

  bool isDriver = false; // Toggle state for driver/client
  bool isSigningUp = false;
  
  @override
  void dispose() {
    emailInputController.dispose();
    usernameInputController.dispose();
    passwordInputController.dispose();
    confirmPasswordInputController.dispose();
    phoneNumberInputController.dispose();
    carTypeInputController.dispose();
    plateNumberInputController.dispose();
    super.dispose();
  }
  TextEditingController confirmPasswordInputController = TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();
  TextEditingController carTypeInputController = TextEditingController(); // New controller for car type
  TextEditingController plateNumberInputController = TextEditingController(); // New controller for plate number

  bool isDriver = false; // Toggle state for driver/client

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      body: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 18.h),
                _buildRefreshSection(context),
                SizedBox(height: 12.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(right: 10.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 22.h,
                    vertical: 28.h,
                  ),
                  decoration: (AppDecoration.outlineBluegray100 != null
                      ? AppDecoration.outlineBluegray100.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder8,
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadiusStyle.roundedBorder8,
                        )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "اسم المستخدم:",
                              style: theme.textTheme.bodyLarge,
                            ),
                            SizedBox(height: 8.h),
                            _buildUsernameInput(context)
                          ],
                        ),
                      ),
                      SizedBox(height: 14.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "كلمة السر:",
                              style: theme.textTheme.bodyLarge,
                            ),
                            SizedBox(height: 8.h),
                            _buildPasswordInput(context)
                          ],
                        ),
                      ),
                      SizedBox(height: 14.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "تأكيد كلمة السر:",
                              style: theme.textTheme.bodyLarge,
                            ),
                            SizedBox(height: 8.h),
                            _buildConfirmPasswordInput(context)
                          ],
                        ),
                      ),
                      SizedBox(height: 14.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "الايميل:",
                              style: theme.textTheme.bodyLarge,
                            ),
                            SizedBox(height: 8.h),
                            _buildEmailInput(context)
                          ],
                        ),
                      ),
                      SizedBox(height: 18.h),
                      _buildUserTypeToggle(context), // Updated toggle switch
                      // Show car type and plate number fields only if user is a driver
                      if (isDriver) ...[
                        SizedBox(height: 14.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "نوع السيارة:",
                                style: theme.textTheme.bodyLarge,
                              ),
                              SizedBox(height: 8.h),
                              _buildCarTypeInput(context)
                            ],
                          ),
                        ),
                        SizedBox(height: 14.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "رقم اللوحة:",
                                style: theme.textTheme.bodyLarge,
                              ),
                              SizedBox(height: 8.h),
                              _buildPlateNumberInput(context)
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: 30.h),
                      _buildRegisterButton(context),
                      SizedBox(height: 14.h)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRefreshSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconButton(
            height: 34.h,
            width: 36.h,
            padding: EdgeInsets.all(2.h),
            decoration: IconButtonStyleHelper.none,
            alignment: Alignment.bottomCenter,
            onTap: () {
              onTapBtnRefreshone(context);
            },
            child: CustomImageView(
              imagePath: ImageConstant.imgRefresh,
            ),
          ),
          Container(
            height: 130.h,
            width: 180.h,
            margin: EdgeInsets.only(
              left: 48.h,
              bottom: 24.h,
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.img5935976241859510486,
                  height: 122.h,
                  width: double.maxFinite,
                  alignment: Alignment.topCenter,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 44.h),
                  child: Text(
                    "تسجيل",
                    style: theme.textTheme.titleLarge,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUsernameInput(BuildContext context) {
    return CustomTextFormField(
      controller: usernameInputController,
      hintText: "ادخل اسم المستخدم",
      contentPadding: EdgeInsets.fromLTRB(12.h, 10.h, 12.h, 6.h),
    );
  }

  /// Section Widget
  Widget _buildPasswordInput(BuildContext context) {
    return CustomTextFormField(
      controller: passwordInputController,
      hintText: "أدخل كلمة السر هنا",
      contentPadding: EdgeInsets.fromLTRB(12.h, 10.h, 12.h, 6.h),
    );
  }

  /// Section Widget
  Widget _buildConfirmPasswordInput(BuildContext context) {
    return CustomTextFormField(
      controller: confirmPasswordInputController,
      hintText: "أدخل تأكيد كلمة السر هنا",
      contentPadding: EdgeInsets.fromLTRB(12.h, 10.h, 12.h, 6.h),
    );
  }

  /// Section Widget
  Widget _buildEmailInput(BuildContext context) {
    return CustomTextFormField(
      controller: emailInputController,
      hintText: "أدخل بريدك الإلكتروني",
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.fromLTRB(12.h, 6.h, 12.h, 2.h),
    );
  }

  /// Section Widget
  Widget _buildCarTypeInput(BuildContext context) {
    return CustomTextFormField(
      controller: carTypeInputController,
      hintText: "أدخل نوع سيارتك",
      contentPadding: EdgeInsets.fromLTRB(12.h, 10.h, 12.h, 6.h),
    );
  }

  /// Section Widget
  Widget _buildPlateNumberInput(BuildContext context) {
    return CustomTextFormField(
      controller: plateNumberInputController,
      hintText: "أدخل رقم لوحة سيارتك",
      contentPadding: EdgeInsets.fromLTRB(12.h, 10.h, 12.h, 6.h),
    );
  }

  /// Section Widget
  Widget _buildUserTypeToggle(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            isDriver ? "سائق" : "عميل",
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(width: 8.h),
          Switch(
            value: isDriver,
            onChanged: (value) {
<<<<<<< Updated upstream
              setState(() {
                isDriver = value;
              });
=======
              isDriver = value;
              // Force rebuild to update the UI
              (context as Element).markNeedsBuild();
>>>>>>> Stashed changes
            },
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRegisterButton(BuildContext context) {
    return CustomElevatedButton(
      text: "تسجيل",
      onPressed: _signup,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgStar,
          height: 16.h,
          width: 16.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// Navigates to the k0Screen when the action is triggered.
  onTapBtnRefreshone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.k0Screen);
  }
<<<<<<< Updated upstream

  void _signup() async {
    setState(() {
      isSigningUp = true;
    });

    try {
      String username = usernameInputController.text;
      String email = emailInputController.text;
      String password = passwordInputController.text;

      User? user = await _auth.signup(email, password);

      if (user != null) {
        showToast(message: "تم إنشاء الحساب بنجاح");
        Navigator.pushNamed(context, "/home");
      } else {
        showToast(message: "حدث خطأ أثناء التسجيل");
      }
    } catch (e) {
      showToast(message: "خطأ: ${e.toString()}");
    } finally {
      setState(() {
        isSigningUp = false;
      });
    }
  }
}
=======
}
>>>>>>> Stashed changes
