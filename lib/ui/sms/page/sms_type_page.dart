import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/sms_query.dart';
import 'package:lighthouse_admin/model/sms_type.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/ui/common/widget/button/border_button.dart';
import 'package:lighthouse_admin/ui/sms/viewmodel/sms_query_model.dart';
import 'package:lighthouse_admin/ui/sms/viewmodel/sms_type_model.dart';

class SmsTypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SmsTypePageState();
  }
}

class SmsTypePageState extends State<SmsTypePage> with BasePageMixin<SmsTypePage> {

  final GlobalKey<PaginatedDataTableState> tableKey = GlobalKey<PaginatedDataTableState>();
  
  int _rowsPerPage = 10;

  Disposer _smsQueryDisposer;
  SmsTypeModel _smsTypeModel = Get.put(SmsTypeModel());

  @override
  void initState() {
    super.initState();

    initViewModel();

    WidgetsBinding.instance.addPostFrameCallback((c) {
      _query();
    });
  }

  @override
  void dispose() {
    if (_smsQueryDisposer != null) {
      _smsQueryDisposer();
    }
    super.dispose();
  }

  void initViewModel() {
    _smsTypeModel.initDS(context, this);
    _smsQueryDisposer = _smsTypeModel.addListener(() {
      if (_smsTypeModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_smsTypeModel.isError) {
        closeProgress();
        BotToast.showText(text: _smsTypeModel.viewStateError.message);

      } else if (_smsTypeModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.current.saved);

      } else if (_smsTypeModel.isIdle) {
        closeProgress();
      }
    });
  }

  _query({bool silent = false}) {
    _smsTypeModel.list(silent: silent);
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmsTypeModel>(builder: (_) => _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    
    ButtonBar buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        Gaps.hGap5,
        BorderButton(width: 80, height: 40,
            text: S.of(context).refresh,
            onPressed: () {
              _query();
            }
          ),
      ],
    );

    Scrollbar table = Scrollbar(
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          PaginatedDataTable(
            key: tableKey,
            header: Text(S.of(context).menuSmsType),
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (int value) {
              setState(() {
                _rowsPerPage = value;
              });
            },
            availableRowsPerPage: <int>[5, 10, 20],
            columns: <DataColumn>[
              DataColumn(label: Text(S.of(context).tableId)),
              DataColumn(label: Text(S.of(context).tableContent)),
            ],
            source: _smsTypeModel.smsTypeDS,
          ),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap10,
          buttonBar,
          Expanded(
            child: table,
          ),
        ],
      ),
    );
  }
}

class SmsTypeDS extends DataTableSource {
  SmsTypeDS();

  SmsTypePageState state;
  BuildContext context;

  SmsTypeModel _smsTypeModel = Get.find<SmsTypeModel>();

  @override
  DataRow getRow(int index) {
    if (index >= _smsTypeModel.smsTypeList.length) {
      return null;
    }

    SmsType smsType = _smsTypeModel.smsTypeList[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(smsType.value.toString() ?? '--')),
        DataCell(Text(smsType.desc ?? '--')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _smsTypeModel.smsTypeList.length;

  @override
  int get selectedRowCount => 0;
}
