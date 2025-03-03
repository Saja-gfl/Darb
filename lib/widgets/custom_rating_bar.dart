import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import '../core/app_export.dart';

// ignore_for_file: must_be_immutable
class CustomRatingBar extends StatelessWidget {
    CustomRatingBar({
        Key? key,
        this.alignment,
        this.ignoreGestures,
        this.initialRating,
        this.itemSize,
        this.itemCount,
        this.color,
        this.unselectedColor,
        this.onRatingUpdate,
    }) : super(key: key);

    final AlignmentGeometry? alignment;
    final bool? ignoreGestures;
    final double? initialRating;
    final double? itemSize;
    final int? itemCount;
    final Color? color;
    final Color? unselectedColor;
    final Function(double)? onRatingUpdate;

    @override
    Widget build(BuildContext context) {
        return alignment != null
            ? Align(
                alignment: alignment ?? Alignment.center,
                child: ratingBarWidget,
              )
            : ratingBarWidget;
    }

    Widget get ratingBarWidget => RatingBar.builder(
        ignoreGestures: ignoreGestures ?? false,
        initialRating: initialRating ?? 0,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemSize: itemSize ?? 24.h,
        // unselectedColor: unselectedColor ?? Colors.grey,
        itemCount: itemCount ?? 5,
        itemBuilder: (context, _) {
            return Icon(
                Icons.star,
                color: color ?? Colors.yellow,
            );
        },
        onRatingUpdate: (rating) {
            onRatingUpdate?.call(rating);
        },
    );
}