import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/global/rt_account.dart';
import 'package:lighthouse_admin/model/account.dart';
import 'package:lighthouse_admin/res/colors.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/res/styles.dart';
import 'package:lighthouse_admin/router/routers.dart';
import 'package:lighthouse_admin/ui/common/widget/button/gradient_button.dart';
import 'package:lighthouse_admin/ui/common/widget/common_scroll_view.dart';
import 'package:lighthouse_admin/ui/common/widget/textfield/account_text_field.dart';
import 'package:lighthouse_admin/ui/common/widget/textfield/pwd_text_field.dart';
import 'package:lighthouse_admin/utils/object_util.dart';
import 'package:lighthouse_admin/utils/other_util.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _pwdNode = FocusNode();

  String _area_code;
  bool _loginEnabled = false;

  @override
  void initState() {
    super.initState();

    initView();
    _checkInput();
  }

  void initView() {
    Account account = RTAccount.instance().loadAccount();
    if (account != null) {
      // var t = account.phone?.split(' ');
      // _area_code = t?.first;
      // _phoneController.text = t?.last;
      _area_code = '+86';
      _phoneController.text = account.phone;
    } else {
      _area_code = '+86';
    }
  }


  void _checkInput() {
    setState(() {
      if (ObjectUtil.isEmpty(_phoneController.text)) {
        _loginEnabled = false;
      } else {
        _loginEnabled = true;
      }
    });
  }

  void _login() {
    String phone = _phoneController.text;
    String pwd = _pwdController.text;
  }

  void _selectArea() {
  }

  void _smsLogin() {

  }

  void _forgetPwd() {

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
                  keyboardConfig: OtherUtil.getKeyboardActionsConfig(context, <FocusNode>[_phoneNode, _pwdNode]),
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 20.0),
                  children: <Widget>[
                    Gaps.vGap16,
                    Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Icon(Icons.person_outline,  color: Colors.blue, size: 60),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        height: 22,
                                        padding: EdgeInsets.only(bottom: 1),
                                        alignment: Alignment.centerLeft,
                                        child: Text(S.of(context).welcomeLogin,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles.textGray800_w400_17)
                                    ),

                                    Container(
                                        height: 22,
                                        alignment: Alignment.centerLeft,
                                        child: Text(S.of(context).welcomeLogin,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles.textGray400_w400_12)
                                    ),

                                  ],
                                )
                            ),

                          ],
                        )
                    )
                    ,
                    Gaps.vGap32,

                    AccountTextField(
                      focusNode: _phoneNode,
                      controller: _phoneController,
                      onTextChanged: _checkInput,
                      onPrefixPressed: _selectArea,
                    ),
                    Gaps.vGap16,
                    PwdTextField(
                      focusNode: _pwdNode,
                      controller: _pwdController,
                      onTextChanged: _checkInput,
                    ),
                    Gaps.vGap46,
                    GradientButton(
                      width: double.infinity,
                      height: 48,
                      text: S.of(context).login,
                      colors: <Color>[   //背景渐变
                        Colours.app_main,
                        Colours.app_main_500
                      ],
                      onPressed: _loginEnabled ? _login : null,
                    ),
                    Gaps.vGap16,

                  ],
                  bottomButton: Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Text.rich(TextSpan(
                          children: [
                            TextSpan(text: S.of(context).noAccount, style: TextStyles.textGray400_w400_14),
                            TextSpan(text: S.of(context).clickRegister, style: TextStyles.textMain14,
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
