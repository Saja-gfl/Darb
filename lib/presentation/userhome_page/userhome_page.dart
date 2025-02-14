import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'widgets/serviceslist_item_widget.dart'; // Ensure this import is correct

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: 8.h,
          top: 36.h,
          right: 8.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomImageView(
              // imagePath: ImageConstant.img939976241859510486,
              height: 56.h,
              width: 116.h,
            ),
            SizedBox(height: 52.h),
            Expanded(
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(right: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 4.h),
                      child: Text(
                        "s-l-us-1",
                        style: CustomTextStyles.titleMediumErrorContainer,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _buildNotificationRow(context),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.maxFinite,
                      child: Divider(
                        endIndent: 4.h,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Padding(
                      padding: EdgeInsets.only(right: 4.h),
                      child: Text(
                        "o).call",
                        style: CustomTextStyles.titleMediumErrorContainer,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _buildServicesList(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Widget: Notification Row
  Widget _buildNotificationRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "تم قبول طلب اشتراكك من قبل السائق أحمد",
                  style: CustomTextStyles.bodyMediumOrange800,
                ),
                Text(
                  "متد ساعتين",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.h),
          Container(
            height: 32.h,
            width: 32.h,
            decoration: AppDecoration.fillBlack.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder16,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  // imagePath: ImageConstant.imgIcon,
                  height: 26.h,
                  width: 24.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Section Widget: Services List
  Widget _buildServicesList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: 24.h,
          right: 4.h,
        ),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 34.h,
            );
          },
          itemCount: 3,
          itemBuilder: (context, index) {
            // return ServicesListItemWidget();
          },
        ),
      ),
    );
  }
}