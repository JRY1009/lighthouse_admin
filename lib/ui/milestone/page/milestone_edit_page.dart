import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/milestone.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/res/styles.dart';
import 'package:lighthouse_admin/ui/common/widget/button/border_button.dart';
import 'package:lighthouse_admin/ui/common/widget/form/form_select_date.dart';
import 'package:lighthouse_admin/ui/common/widget/form/multiselect_formfield.dart';
import 'package:lighthouse_admin/ui/milestone/viewmodel/milestone_model.dart';
import 'package:lighthouse_admin/utils/object_util.dart';

class MilestoneEditPage extends StatefulWidget {
  final Milestone milestone;
  const MilestoneEditPage({Key key, this.milestone}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MilestoneEditPageState();
  }
}

class MilestoneEditPageState extends State<MilestoneEditPage> with BasePageMixin<MilestoneEditPage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Disposer _milestoneDisposer;
  MilestoneModel _milestoneModel = Get.find<MilestoneModel>();

  List _tags = [];
  Milestone formData = Milestone();

  @override
  void initState() {
    super.initState();

    formData = widget.milestone ?? Milestone();
    _tags = formData.tag?.split(',') ?? [];

    initViewModel();
  }

  @override
  void dispose() {
    if (_milestoneDisposer != null) {
      _milestoneDisposer();
    }
    super.dispose();
  }

  void initViewModel() {
    _milestoneDisposer = _milestoneModel.addListener(() {
      if (_milestoneModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_milestoneModel.isError) {
        closeProgress();
        BotToast.showText(text: _milestoneModel.viewStateError.message);

      } else if (_milestoneModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.of(context).saved);
        Get.back(result: true);

      } else if (_milestoneModel.isIdle) {
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

    if (widget.milestone != null) {
      _milestoneModel.edit(formData);
    } else {
      _milestoneModel.add(formData);
    }
  }

  @override
  Widget build(BuildContext context) {

    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          FormSelectDate(
            context: context,
            value: formData.date,
            label: S.of(context).tableDate,
            onSaved: (v) {
              formData.date = v;
            },
          ),

          Container(
            padding: EdgeInsets.all(20.0),
            child: MultiSelectFormField(
              autovalidate: false,
              border: OutlineInputBorder(),
              chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
              dialogShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text(S.of(context).tableTag),
              validator: (value) {
                return ObjectUtil.isEmptyList(value) ? S.of(context).tableRequried: null;
              },
              dataSource: [
                {"display": "all", "value": "all"},
                {"display": "bitcoin", "value": "bitcoin"},
                {"display": "ethereum", "value": "ethereum"},
                {"display": "usdt", "value": "usdt"},
                {"display": "decp", "value": "decp"},
              ],
              textField: 'display',
              valueField: 'value',
              okButtonLabel: S.of(context).confirm,
              cancelButtonLabel: S.of(context).cancel,
              hintWidget: Text(S.of(context).tableRequried, style: TextStyles.textGray400_w400_14),
              initialValue: _tags,
              onSaved: (value) {
                if (value == null) return;
                _tags = value;

                String result;
                _tags.forEach((text) {
                  if (ObjectUtil.isEmptyString(result))
                    result = text;
                  else
                    result = '$result,$text';
                });

                formData.tag = result ?? '';
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            width: double.infinity,
            child: TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: S.of(context).tableContent,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
              controller: TextEditingController(text: formData.content),
              onSaved: (v) {
                formData.content = v;
              },
              validator: (v) {
                return v.isEmpty ? S.of(context).tableRequried: null;
              },
            ),
          )
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
        title: Text(widget.milestone == null ? S.of(context).add : S.of(context).modify),
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

    return SizedBox(
      width: 650,
      height: 500,
      child: result,
    );
  }
}
