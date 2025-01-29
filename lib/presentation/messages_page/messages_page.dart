import 'package:flutter/material.dart';
import '../../core/app_export.dart'; // ignore_for_file: must_be_immutable

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(
          top: 34.h,
          right: 28.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "المحادثات",
              style: theme.textTheme.headlineSmall,
            )
          ],
        ),
      ),
    );
  }
}
