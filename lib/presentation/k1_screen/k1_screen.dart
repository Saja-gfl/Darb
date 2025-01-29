import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class K1Screen extends StatelessWidget {
  K1Screen({Key? key})
      : super(
          key: key,
        );

  TextEditingController usernameInputController = TextEditingController();

  TextEditingController passwordInputController = TextEditingController();

  TextEditingController confirmPasswordInputController =
      TextEditingController();

  TextEditingController phoneNumberInputController = TextEditingController();

  String radioGroup = "";

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
                  decoration: AppDecoration.outlineBluegray100.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
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
                              "رقم الهاتف:",
                              style: theme.textTheme.bodyLarge,
                            ),
                            SizedBox(height: 8.h),
                            _buildPhoneNumberInput(context)
                          ],
                        ),
                      ),
                      SizedBox(height: 18.h),
                      _buildUserTypeSelection(context),
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
  Widget _buildPhoneNumberInput(BuildContext context) {
    return CustomTextFormField(
      controller: phoneNumberInputController,
      hintText: "أدخل رقم هاتفك الصحيح",
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.fromLTRB(12.h, 6.h, 12.h, 2.h),
    );
  }

  /// Section Widget
  Widget _buildUserTypeSelection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 96.h),
            child: CustomRadioButton(
              text: "سائق",
              value: "سائق",
              groupValue: radioGroup,
              onChange: (value) {
                radioGroup = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 6.h),
            child: CustomRadioButton(
              text: "عميل",
              value: "عميل",
              groupValue: radioGroup,
              onChange: (value) {
                radioGroup = value;
              },
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRegisterButton(BuildContext context) {
    return CustomElevatedButton(
      text: "تسجيل",
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
}
