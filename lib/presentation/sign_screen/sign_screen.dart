import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignScreen extends StatelessWidget {
  SignScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController inputoneController = TextEditingController();

  TextEditingController inputthreeController = TextEditingController();

  TextEditingController inputfiveController = TextEditingController();

  TextEditingController inputsevenController = TextEditingController();

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
                _buildRefreshRow(context),
                SizedBox(height: 12.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(right: 10.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 22.h,
                    vertical: 28.h,
                  ),
                  decoration: AppDecoration.outlineBluegray100.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder6,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildUsernameInputField(context),
                      SizedBox(height: 14.h),
                      _buildPasswordInputField(context),
                      SizedBox(height: 14.h),
                      _buildConfirmPasswordInputField(context),
                      SizedBox(height: 14.h),
                      _buildPhoneNumberInputField(context),
                      SizedBox(height: 18.h),
                      _buildUserTypeRadioGroup(context),
                      SizedBox(height: 30.h),
                      CustomElevatedButton(
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
                      ),
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
  Widget _buildRefreshRow(BuildContext context) {
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
  Widget _buildUsernameInputField(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "اسم المستخدم:",
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 8.h),
          CustomTextFormField(
            controller: inputoneController,
            hintText: "ادخل اسم المستخدم",
            contentPadding: EdgeInsets.fromLTRB(12.h, 10.h, 12.h, 6.h),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordInputField(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "كلمة السر:",
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 8.h),
          CustomTextFormField(
            controller: inputthreeController,
            hintText: "أدخل كلمة السر هنا",
            contentPadding: EdgeInsets.fromLTRB(12.h, 10.h, 12.h, 6.h),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildConfirmPasswordInputField(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "تأكيد كلمة السر:",
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 8.h),
          CustomTextFormField(
            controller: inputfiveController,
            hintText: "أدخل تأكيد كلمة السر هنا",
            contentPadding: EdgeInsets.fromLTRB(12.h, 10.h, 12.h, 6.h),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPhoneNumberInputField(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "رقم الهاتف:",
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 8.h),
          CustomTextFormField(
            controller: inputsevenController,
            hintText: "أدخل رقم هاتفك الصحيح",
            textInputAction: TextInputAction.done,
            contentPadding: EdgeInsets.fromLTRB(12.h, 6.h, 12.h, 2.h),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUserTypeRadioGroup(BuildContext context) {
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
}
