import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class SubscriptionoptionsItemWidget extends StatelessWidget {
  const SubscriptionoptionsItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: AppDecoration.outlineBlackC.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 150.h,
            width: double.maxFinite,
            decoration: AppDecoration.outlineBlack9000c,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgImage4,
                  height: 150.h,
                  width: 148.h,
                )
              ],
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(right: 8.h),
            child: Text(
              "عرض الاشتراكات الجارية",
              style: theme.textTheme.bodySmall,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            width: 126.h,
            margin: EdgeInsets.only(right: 8.h),
            child: Text(
              "تتبع رحلاتك الحالية مع السائقين",
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelMedium,
            ),
          ),
          SizedBox(height: 14.h)
        ],
      ),
    );
  }
}
