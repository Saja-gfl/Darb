import 'package:flutter/material.dart';
import '/core/app_export.dart';

class ServiceslistItemWidget extends StatelessWidget {
  const ServiceslistItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: AppDecoration.outlineBlack900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "trylet = src",
                    style: CustomTextStyles.bodySmallOrange800,
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: 126.h,
                    child: Text(
                      "عرف الاشتراكات الجارية",
                      style: CustomTextStyles.bodySmallOrange800,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: 126.h,
                    child: Text(
                      "تتبع رحلات الحالية مع السائقين",
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.h),
          CustomImageView(
            imagePath: ImageConstant.imgTelevision,
            height: 32.h,
            width: 34.h,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}