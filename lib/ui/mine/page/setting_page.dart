import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/res/colors.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/res/styles.dart';
import 'package:lighthouse_admin/router/routers.dart';
import 'package:lighthouse_admin/ui/common/widget/common_scroll_view.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  void initState() {
    super.initState();

    initView();
  }

  void initView() {
  }

  void _jump2Register() {
    Get.offNamed(Routers.loginPage);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset:false,
        backgroundColor: Colours.normal_bg,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          brightness: Brightness.light,
          backgroundColor: Colours.white,
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: Container(
                alignment: Alignment.center,
                height: 400,
                constraints: BoxConstraints(minWidth: 240, maxWidth: 500),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  color: Colors.white,
                ),
                child: CommonScrollView(
                  children: <Widget>[
                    Gaps.vGap16,
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        alignment: Alignment.centerLeft,
                        child: SelectableText('没账号？用这个\nAccount：legend9999@126.com\nPassword：lizhiwei1234',
                            maxLines: 10,
                            strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
                            style: TextStyles.textBlack20)
                    )
                  ],
                  bottomButton: Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Text.rich(TextSpan(
                          children: [
                            TextSpan(text: '点击此处 --> ', style: TextStyles.textGray400_w400_14),
                            TextSpan(text: '返回登录', style: TextStyles.textMain14,
                                recognizer: new TapGestureRecognizer()..onTap = _jump2Register),
                          ]
                      ))
                  ),
                )
            )
        )
    );
  }

}
