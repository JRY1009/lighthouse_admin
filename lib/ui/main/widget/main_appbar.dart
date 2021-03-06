import 'package:flutter/material.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/global/rt_account.dart';
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/res/styles.dart';
import 'package:lighthouse_admin/utils/other_util.dart';

class MainAppBar extends AppBar {

  MainAppBar(
      BuildContext context, {
        Key key,
        openSetting,
        openMenu,
        openMine,
      }) : super(
    key: key,
    automaticallyImplyLeading: false,
    leading: Tooltip(
        message: S.of(context).home,
        child: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            OtherUtil.launchURL(Apis.URL_OFFICIAL_WEBSITE);
          },
        )),
    title: Text(S.of(context).appName, style: TextStyles.textWhite18),
    actions: <Widget>[
      Tooltip(
        message: S.of(context).setting,
        child: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            openSetting();
          },
        ),
      ),
      Tooltip(
        message: S.of(context).mine,
        child: IconButton(
            icon: Icon(Icons.person),
            onPressed: () { openMine(); }
        ),
      ),
      Tooltip(
        message: S.of(context).logout,
        child: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            RTAccount.instance().logout();
          },
        ),
      ),
    ],
  );
}
