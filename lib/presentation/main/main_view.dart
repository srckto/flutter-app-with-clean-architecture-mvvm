import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/constants.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/presentation/main/pages/home/view/home_page.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/main/pages/notifications/view/notifications_pages.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/main/pages/search/view/search_page.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/main/pages/settings/view/settings_pages.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';

class BottomNavObject {
  String title;
  Widget page;
  Widget icon;

  BottomNavObject({
    required this.title,
    required this.page,
    required this.icon,
  });
}

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<BottomNavObject> items = [
    BottomNavObject(
      title: AppStrings.home.tr(),
      page: HomePage(),
      icon: Icon(Icons.home_outlined),
    ),
    BottomNavObject(
      title: AppStrings.search.tr(),
      page: SearchPage(),
      icon: Icon(Icons.search_outlined),
    ),
    BottomNavObject(
      title: AppStrings.notifications.tr(),
      page: NotificationsPages(),
      icon: Icon(Icons.notifications_outlined),
    ),
    BottomNavObject(
      title: AppStrings.settings.tr(),
      page: SettingsPage(),
      icon: Icon(Icons.settings_outlined),
    ),
  ];

  int currentIndex = 0;

  void onChange(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(items[currentIndex].title),
      ),
      body: items[currentIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        onTap: onChange,
        currentIndex: currentIndex,
        items: items
            .map(
              (e) => BottomNavigationBarItem(
                icon: e.icon,
                label: Constants.empty,
                backgroundColor: ColorManager.white,
              ),
            )
            .toList(),
      ),
    );
  }
}
