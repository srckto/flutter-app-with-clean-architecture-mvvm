import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/app_storage.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/di.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppStorage _appStorage = sl<AppStorage>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: SvgPicture.asset(ImageAssets.settings),
          title: Text(AppStrings.changeLanguage.tr()),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () async {
            await _appStorage.changeApplicationLanguage();
            Phoenix.rebirth(context);
          },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.contactUs),
          title: Text(AppStrings.contactUs.tr()),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.inviteFriends),
          title: Text(AppStrings.inviteYourFriends.tr()),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.logout),
          title: Text(AppStrings.logout.tr()),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ],
    );
  }
}
