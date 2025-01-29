import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/app_export.dart';
import 'widgets/subscriptionoptions_item_widget.dart'; // ignore_for_file: must_be_immutable

class HomePage extends StatelessWidget {
  const HomePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      body: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgTop,
                  height: 18.h,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(right: 12.h),
                ),
                SizedBox(height: 10.h),
                CustomImageView(
                  imagePath: ImageConstant.img5935976241859510486,
                  height: 56.h,
                  width: 116.h,
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 12.h),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(
                    left: 24.h,
                    right: 34.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "الخدمات",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 8.h),
                      _buildSubscriptionOptions(context)
                    ],
                  ),
                ),
                SizedBox(height: 34.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 52.h),
                    child: Text(
                      "الاشعارات",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 52.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "تم قبول طلب اشتراكك من قبل السائق أحمد.",
                              style: CustomTextStyles.bodyMediumRobotoOrange800,
                            ),
                            Text(
                              "منذ ساعتين",
                              style: CustomTextStyles.bodySmallBlack9000c,
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 8.h),
                      Container(
                        height: 32.h,
                        width: 32.h,
                        decoration: AppDecoration.fillBlackC.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder16,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgIcon,
                              height: 26.h,
                              width: 24.h,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 340.h,
                    child: Divider(
                      indent: 6.h,
                    ),
                  ),
                ),
                SizedBox(height: 62.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSubscriptionOptions(BuildContext context) {
    return ResponsiveGridListBuilder(
      minItemWidth: 1,
      minItemsPerRow: 2,
      maxItemsPerRow: 2,
      horizontalGridSpacing: 34.h,
      verticalGridSpacing: 34.h,
      builder: (context, items) => ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: items,
      ),
      gridItems: List.generate(
        3,
        (index) {
          return SubscriptionoptionsItemWidget();
        },
      ),
    );
  }
}
