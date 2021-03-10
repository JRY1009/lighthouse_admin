import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/chain_info.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/ui/chaininfo/viewmodel/chain_info_model.dart';
import 'package:lighthouse_admin/ui/common/widget/button/border_button.dart';
import 'package:lighthouse_admin/ui/common/widget/form/form_input.dart';
import 'package:lighthouse_admin/ui/common/widget/form/form_select.dart';
import 'package:lighthouse_admin/ui/common/widget/form/form_select_date.dart';
import 'package:lighthouse_admin/ui/common/widget/textfield/precision_limit_formatter.dart';
import 'package:lighthouse_admin/utils/screen_util.dart';

class ChainInfoEditPage extends StatefulWidget {
  final ChainInfo chainInfo;
  const ChainInfoEditPage({Key key, this.chainInfo}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ChainInfoEditPageState();
  }
}

class ChainInfoEditPageState extends State<ChainInfoEditPage> with BasePageMixin<ChainInfoEditPage> {
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Disposer _chainInfoDisposer;
  ChainInfoModel _chainInfoModel = Get.find<ChainInfoModel>();

  ChainInfo formData = ChainInfo();
  
  @override
  void initState() {
    super.initState();

    formData = widget.chainInfo ?? ChainInfo();
    initViewModel();
  }

  @override
  void dispose() {
    if (_chainInfoDisposer != null) {
      _chainInfoDisposer();
    }
    super.dispose();
  }

  void initViewModel() {
    _chainInfoDisposer = _chainInfoModel.addListener(() {
      if (_chainInfoModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_chainInfoModel.isError) {
        closeProgress();
        BotToast.showText(text: _chainInfoModel.viewStateError.message);

      } else if (_chainInfoModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.of(context).saved);
        Get.back(result: true);

      } else if (_chainInfoModel.isIdle) {
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

    if (widget.chainInfo != null) {
      _chainInfoModel.edit(formData);
    } else {
      _chainInfoModel.add(formData);
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
            value: formData.symbol,
            label: S.of(context).tableSymbol,
            onSaved: (v) {
              formData.symbol = v;
            },
          ),
          FormInput(
            value: formData.chain,
            label: S.of(context).tableChain,
            onSaved: (v) {
              formData.chain = v;
            },
          ),
          FormInput(
            value: formData.total_market_value?.toString(),
            label: S.of(context).tableTotalMarketValue,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormatters: [PrecisionLimitFormatter(6)],
            onSaved: (v) {
              formData.total_market_value = num.parse(v);
            },
          ),
          FormInput(
            value: formData.ratio?.toString(),
            label: S.of(context).tableRatio,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormatters: [PrecisionLimitFormatter(6)],
            onSaved: (v) {
              formData.ratio = num.parse(v);
            },
          ),
          FormInput(
            value: formData.total_supply?.toString(),
            label: S.of(context).tableTotalSupply,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
            onSaved: (v) {
              formData.total_supply = num.parse(v);
            },
          ),
          FormInput(
            value: formData.core_algorithm,
            label: S.of(context).tableCoreAlgorithm,
            onSaved: (v) {
              formData.core_algorithm = v;
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            width: double.infinity,
            child: TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: S.of(context).tableCoreAlgorithmRemark,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
              controller: TextEditingController(text: formData.core_algorithm_remark),
              onSaved: (v) {
                formData.core_algorithm_remark = v;
              },
            ),
          ),
          FormInput(
            value: formData.consensus_mechanism,
            label: S.of(context).tableConsensusMechanism,
            onSaved: (v) {
              formData.consensus_mechanism = v;
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            width: double.infinity,
            child: TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: S.of(context).tableConsensusMechanismRemark,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
              controller: TextEditingController(text: formData.consensus_mechanism_remark),
              onSaved: (v) {
                formData.consensus_mechanism_remark = v;
              },
            ),
          ),
          FormSelectDate(
            context: context,
            value: formData.start_date,
            label: S.of(context).tableStartDate,
            onSaved: (v) {
              formData.start_date = v;
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            width: double.infinity,
            child: TextFormField(
              maxLines: 8,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: S.of(context).tableContent,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
              controller: TextEditingController(text: formData.content),
              onSaved: (v) {
                formData.content = v;
              },
            ),
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
        title: Text(widget.chainInfo == null ? S.of(context).add : S.of(context).modify),
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
      height: 650,
      child: result,
    );
  }
}
