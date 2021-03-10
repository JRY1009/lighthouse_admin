import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/global/rt_account.dart';
import 'package:lighthouse_admin/model/account.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/res/styles.dart';
import 'package:lighthouse_admin/ui/common/widget/common_scroll_view.dart';
import 'package:lighthouse_admin/ui/common/widget/form/form_input.dart';
import 'package:lighthouse_admin/ui/tag/viewmodel/tag_model.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> with BasePageMixin<MinePage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<TagModel>(builder: (_) => _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {

    Account account = RTAccount.instance().getActiveAccount();
    var formBar = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          FormInput(
            enable: false,
            value: account?.id.toString(),
            label: S.of(context).tableId,
          ),
          FormInput(
            enable: false,
            value: account?.email,
            label: S.of(context).tableEmail,
          ),
          FormInput(
            enable: false,
            value: account?.phone,
            label: S.of(context).tablePhone,
          ),
        ],
      ),
    );

    return Scaffold(
      body: CommonScrollView(
        children: <Widget>[
          Gaps.vGap16,
          formBar,
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
      )
    );
  }
}
