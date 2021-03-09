import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/tag.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/ui/common/widget/button/border_button.dart';
import 'package:lighthouse_admin/ui/common/widget/form/form_input.dart';
import 'package:lighthouse_admin/ui/tag/viewmodel/tag_model.dart';
import 'package:lighthouse_admin/utils/screen_util.dart';

class TagEditPage extends StatefulWidget {
  final Tag tag;
  const TagEditPage({Key key, this.tag}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return TagEditPageState();
  }
}

class TagEditPageState extends State<TagEditPage> with BasePageMixin<TagEditPage> {
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Disposer _tagDisposer;
  TagModel _tagModel = Get.find<TagModel>();

  Tag formData = Tag();
  
  @override
  void initState() {
    super.initState();

    formData = widget.tag ?? Tag();
    initViewModel();
  }

  @override
  void dispose() {
    if (_tagDisposer != null) {
      _tagDisposer();
    }
    super.dispose();
  }

  void initViewModel() {
    _tagDisposer = _tagModel.addListener(() {
      if (_tagModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_tagModel.isError) {
        closeProgress();
        BotToast.showText(text: _tagModel.viewStateError.message);

      } else if (_tagModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.of(context).saved);
        Get.back(result: true);

      } else if (_tagModel.isIdle) {
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

    if (widget.tag != null) {
      _tagModel.edit(formData);
    } else {
      _tagModel.add(formData);
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
            value: formData.remark,
            label: S.of(context).tableRemark,
            onSaved: (v) {
              formData.remark = v;
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
        title: Text(widget.tag == null ? S.of(context).add : S.of(context).modify),
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
