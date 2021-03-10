import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/sms_query.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/ui/common/widget/button/border_button.dart';
import 'package:lighthouse_admin/ui/sms/viewmodel/sms_query_model.dart';

class SmsQueryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SmsQueryPageState();
  }
}

class SmsQueryPageState extends State<SmsQueryPage> with BasePageMixin<SmsQueryPage> {

  final GlobalKey<PaginatedDataTableState> tableKey = GlobalKey<PaginatedDataTableState>();
  
  int _rowsPerPage = 10;

  Disposer _smsQueryDisposer;
  SmsQueryModel _smsQueryModel = Get.put(SmsQueryModel());

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
    _smsQueryModel.initDS(context, this);
    _smsQueryModel.page_size = _rowsPerPage;
    _smsQueryDisposer = _smsQueryModel.addListener(() {
      if (_smsQueryModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_smsQueryModel.isError) {
        closeProgress();
        BotToast.showText(text: _smsQueryModel.viewStateError.message);

      } else if (_smsQueryModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.current.saved);

      } else if (_smsQueryModel.isIdle) {
        closeProgress();
      }
    });
  }

  _query({bool silent = false}) {
    _smsQueryModel.list(silent: silent);
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmsQueryModel>(builder: (_) => _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    
    ButtonBar buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        Gaps.hGap5,
        BorderButton(width: 80, height: 40,
            text: S.of(context).refresh,
            onPressed: () {
              if (_smsQueryModel.page_num <= 1) {
                _query();
              } else {
                tableKey.currentState.pageTo(0);
              }
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
            header: Text(S.of(context).menuSmsQuery),
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (int value) {
              _rowsPerPage = value;
              _smsQueryModel.page_size = value;
              if (_smsQueryModel.page_num <= 1) {
                _query();
              } else {
                tableKey.currentState.pageTo(0);
              }
            },
            availableRowsPerPage: <int>[5, 10, 20],
            onPageChanged: (firstRowIndex){
              _smsQueryModel.page_num = (firstRowIndex / _smsQueryModel.page_size).toInt() + 1;
              _query();
            },
            columns: <DataColumn>[
              DataColumn(label: Text(S.of(context).tableYn)),
              DataColumn(label: Text(S.of(context).tableId)),
              DataColumn(label: Text(S.of(context).tablePhone)),
              DataColumn(label: Text(S.of(context).tableTemplate)),
              DataColumn(label: Text(S.of(context).tableContent)),
              DataColumn(label: Text(S.of(context).tableResponse)),
              DataColumn(label: Text(S.of(context).tableRemark)),
              DataColumn(label: Text(S.of(context).tableCreateAt)),
              DataColumn(label: Text(S.of(context).tableUpdateAt)),
            ],
            source: _smsQueryModel.smsQueryDS,
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

class SmsQueryDS extends DataTableSource {
  SmsQueryDS();

  SmsQueryPageState state;
  BuildContext context;

  SmsQueryModel _smsQueryModel = Get.find<SmsQueryModel>();

  @override
  DataRow getRow(int index) {
    if (index >= _smsQueryModel.smsQueryList.length) {
      return null;
    }

    SmsQuery smsQuery = _smsQueryModel.smsQueryList[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Row(
          children: [
            Text(smsQuery.success ? S.of(context).tableSuccess : S.of(context).tableFail),
          ]
        )),
        DataCell(Text(smsQuery.id.toString() ?? '--')),
        DataCell(Text(smsQuery.phone ?? '--')),
        DataCell(Text(smsQuery.template ?? '--')),
        DataCell(Text(smsQuery.content ?? '--')),
        DataCell(Text(smsQuery.response ?? '--')),
        DataCell(Text(smsQuery.remark ?? '--')),
        DataCell(Text(smsQuery.created_at ?? '--')),
        DataCell(Text(smsQuery.updated_at ?? '--')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _smsQueryModel.count;

  @override
  int get selectedRowCount => 0;
}
