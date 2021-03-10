import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/exchange.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/ui/common/widget/button/border_button.dart';
import 'package:lighthouse_admin/ui/common/widget/form/form_input.dart';
import 'package:lighthouse_admin/ui/exchange/viewmodel/exchange_model.dart';
import 'package:lighthouse_admin/utils/screen_util.dart';

class ExchangeEditPage extends StatefulWidget {
  final Exchange exchange;
  const ExchangeEditPage({Key key, this.exchange}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ExchangeEditPageState();
  }
}

class ExchangeEditPageState extends State<ExchangeEditPage> with BasePageMixin<ExchangeEditPage> {
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Disposer _exchangeDisposer;
  ExchangeModel _exchangeModel = Get.find<ExchangeModel>();

  Exchange formData = Exchange();
  
  @override
  void initState() {
    super.initState();

    formData = widget.exchange ?? Exchange();
    initViewModel();
  }

  @override
  void dispose() {
    if (_exchangeDisposer != null) {
      _exchangeDisposer();
    }
    super.dispose();
  }

  void initViewModel() {
    _exchangeDisposer = _exchangeModel.addListener(() {
      if (_exchangeModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_exchangeModel.isError) {
        closeProgress();
        BotToast.showText(text: _exchangeModel.viewStateError.message);

      } else if (_exchangeModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.of(context).saved);
        Get.back(result: true);

      } else if (_exchangeModel.isIdle) {
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

    if (widget.exchange != null) {
      _exchangeModel.edit(formData);
    } else {
      _exchangeModel.add(formData);
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
            value: formData.ico,
            label: S.of(context).tableIco,
            onSaved: (v) {
              formData.ico = v;
            },
          ),
          FormInput(
            value: formData.url,
            label: S.of(context).tableUrl,
            onSaved: (v) {
              formData.url = v;
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
        title: Text(widget.exchange == null ? S.of(context).add : S.of(context).modify),
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
