import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/global/rt_account.dart';
import 'package:lighthouse_admin/model/account.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/colors.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/res/styles.dart';
import 'package:lighthouse_admin/router/routers.dart';
import 'package:lighthouse_admin/ui/common/widget/button/gradient_button.dart';
import 'package:lighthouse_admin/ui/common/widget/common_scroll_view.dart';
import 'package:lighthouse_admin/ui/common/widget/textfield/account_text_field.dart';
import 'package:lighthouse_admin/ui/common/widget/textfield/pwd_text_field.dart';
import 'package:lighthouse_admin/ui/mine/viewmodel/login_model.dart';
import 'package:lighthouse_admin/utils/object_util.dart';
import 'package:lighthouse_admin/utils/other_util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with BasePageMixin<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _pwdNode = FocusNode();

  bool _loginEnabled = false;

  LoginModel _loginModel = Get.put(LoginModel());

  @override
  void initState() {
    super.initState();

    initView();
    initViewModel();

    _checkInput();
  }

  void initView() {
    Account account = RTAccount.instance().loadAccount();
    _emailController.text = account?.email;
  }

  void initViewModel() {
    _loginModel.addListener(() {
      if (_loginModel.isBusy) {
        showProgress(content: S.current.logingin);

      } else if (_loginModel.isError) {
        closeProgress();
        BotToast.showText(text: _loginModel.viewStateError.message);

      } else if (_loginModel.isSuccess) {
        closeProgress();
        Get.offNamed(Routers.mainPage);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loginModel.tokenDelay();
      }
    });
  }

  void _checkInput() {
    setState(() {
      if (ObjectUtil.isEmpty(_emailController.text)) {
        _loginEnabled = false;
      } else {
        _loginEnabled = true;
      }
    });
  }

  void _login() {
    String email = _emailController.text;
    String password = _pwdController.text;

    _loginModel.login(email, password);
  }

  void _jump2Register() {
    Get.toNamed(Routers.settingPage);
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
                keyboardConfig: OtherUtil.getKeyboardActionsConfig(context, <FocusNode>[_emailNode, _pwdNode]),
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
                                    child: Text(S.of(context).appName,
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
                    focusNode: _emailNode,
                    controller: _emailController,
                    onTextChanged: _checkInput,
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
//                    child: Text.rich(TextSpan(
//                        children: [
//                          TextSpan(text: S.of(context).noAccount, style: TextStyles.textGray400_w400_14),
//                          TextSpan(text: S.of(context).clickRegister, style: TextStyles.textMain14,
//                              recognizer: new TapGestureRecognizer()..onTap = _jump2Register),
//                        ]
//                    ))
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        child: SelectableText('legend9999@126.com / lizhiwei1234',
                            maxLines: 1,
                            strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
                            style: TextStyles.textGray800_w400_12)
                    )
                ),
              )
          )
        )
    );
  }

}
