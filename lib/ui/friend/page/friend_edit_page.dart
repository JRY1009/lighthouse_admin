import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/friend.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/ui/common/widget/button/border_button.dart';
import 'package:lighthouse_admin/ui/common/widget/form/form_input.dart';
import 'package:lighthouse_admin/ui/common/widget/form/form_select.dart';
import 'package:lighthouse_admin/ui/friend/viewmodel/friend_model.dart';
import 'package:lighthouse_admin/utils/screen_util.dart';

class FriendEditPage extends StatefulWidget {
  final Friend friend;
  const FriendEditPage({Key key, this.friend}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FriendEditPageState();
  }
}

class FriendEditPageState extends State<FriendEditPage> with BasePageMixin<FriendEditPage> {
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Disposer _friendDisposer;
  FriendModel _friendModel = Get.find<FriendModel>();

  Friend formData = Friend();
  
  @override
  void initState() {
    super.initState();

    formData = widget.friend ?? Friend();
    initViewModel();
  }

  @override
  void dispose() {
    if (_friendDisposer != null) {
      _friendDisposer();
    }
    super.dispose();
  }

  void initViewModel() {
    _friendDisposer = _friendModel.addListener(() {
      if (_friendModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_friendModel.isError) {
        closeProgress();
        BotToast.showText(text: _friendModel.viewStateError.message);

      } else if (_friendModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.of(context).saved);
        Get.back(result: true);

      } else if (_friendModel.isIdle) {
        closeProgress();
      }
    });
  }

  void _edit() {
    FormState form = formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();

    if (widget.friend != null) {
      _friendModel.edit(formData);
    } else {
      _friendModel.add(formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          FormInput(
            value: formData.name,
            label: S.of(context).tableName,
            onSaved: (v) {
              formData.name = v;
            },
            validator: (v) {
              return v.isEmpty ? S.of(context).tableRequried: null;
            },
          ),
          FormInput(
            value: formData.url,
            label: S.of(context).tableUrl,
            onSaved: (v) {
              formData.url = v;
            },
          ),
          FormSelect(
            label: S.of(context).tableCategory,
            value: formData.category,
            dataList: [
              SelectOptionVO(value: 1, label: 'bitcoin'),
              SelectOptionVO(value: 2, label: 'ethereum'),
            ],
            onSaved: (v) {
              formData.category = v;
            },
          ),
        ],
      ),
    );
    ButtonBar buttonBar = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        BorderButton(
            width: 80,
            height: 40,
            text: S.of(context).save,
            onPressed: () => _edit()
        ),
        BorderButton(
            width: 80,
            height: 40,
            text: S.of(context).cancel,
            onPressed: () => Get.back()
        ),
      ],
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(widget.friend == null ? S.of(context).add : S.of(context).modify),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.vGap18,
            form,
          ],
        ),
      ),
      bottomNavigationBar: buttonBar,
    );

    bool horizontal = ScreenUtil.instance().screenWidth > 1000.0;
    return SizedBox(
      width: 650,
      height: horizontal ? 350 : 500,
      child: result,
    );
  }
}
