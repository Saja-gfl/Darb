import 'package:flutter/material.dart';
// import 'package:reem_s_application9/core/app_export.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/custom_text_style.dart';
import 'package:rem_s_appliceation9/widgets/custom_image_view.dart';

class ServicesListItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;

  const ServicesListItemWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.h,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: iconPath,
            height: 24.h,
            width: 24.h,
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: CustomTextStyles.titleMediumBold,
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: CustomTextStyles.bodySmallGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}