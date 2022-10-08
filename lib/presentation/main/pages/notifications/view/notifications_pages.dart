


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';

class NotificationsPages extends StatefulWidget {
  NotificationsPages({Key? key}) : super(key: key);

  @override
  _NotificationsPagesState createState() => _NotificationsPagesState();
}

class _NotificationsPagesState extends State<NotificationsPages> {
  @override
  Widget build(BuildContext context) {
     return Center(
      child: Text(AppStrings.notifications.tr()),
    );
  }
}