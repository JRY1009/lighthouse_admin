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
import 'package:lighthouse_admin/ui/exchange/page/exchange_edit_page.dart';
import 'package:lighthouse_admin/ui/exchange/viewmodel/exchange_model.dart';

class ExchangePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExchangePageState();
  }
}

class ExchangePageState extends State<ExchangePage> with BasePageMixin<ExchangePage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  int _rowsPerPage = 10;

  Disposer _friendDisposer;
  ExchangeModel _exchangeModel = Get.put(ExchangeModel());

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
    if (_friendDisposer != null) {
      _friendDisposer();
    }
    super.dispose();
  }

  void initViewModel() {
    _exchangeModel.initDS(context, this);
    _friendDisposer = _exchangeModel.addListener(() {
      if (_exchangeModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_exchangeModel.isError) {
        closeProgress();
        BotToast.showText(text: _exchangeModel.viewStateError.message);

      } else if (_exchangeModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.current.saved);

      } else if (_exchangeModel.isIdle) {
        closeProgress();
      }
    });
  }

  _query({bool silent = false}) {
    _exchangeModel.list(silent: silent);
  }

  _edit({Exchange exchange}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: ExchangeEditPage(
          exchange: exchange,
        ),
      ),
    ).then((value) {
      // 添加项目后 刷新一下
      if (value == true && exchange == null) {
        _query(silent: true);
      }
    });
  }

  _change_status(id, status) {
    _exchangeModel.change_status(id, status);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExchangeModel>(builder: (_) => _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {

    ButtonBar buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        Gaps.hGap10,
        BorderButton(width: 80, height: 40, text: S.of(context).refresh, onPressed: () => _query()),
        BorderButton(width: 80, height: 40, text: S.of(context).add, onPressed: () => _edit()),
      ],
    );

    Scrollbar table = Scrollbar(
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          PaginatedDataTable(
            header: Text(S.of(context).menuExchange),
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (int value) {
              setState(() {
                _rowsPerPage = value;
              });
            },
            availableRowsPerPage: <int>[10, 20],
            onPageChanged: (index){},
            columns: <DataColumn>[
              DataColumn(
                label: Text(S.of(context).tableYn),
              ),
              DataColumn(
                label: Text(S.of(context).tableId),
              ),
              DataColumn(
                label: Text(S.of(context).tableName),
              ),
              DataColumn(
                label: Text(S.of(context).tableIco),
              ),
              DataColumn(
                label: Text(S.of(context).tableUrl),
              ),
              DataColumn(
                label: Text(S.of(context).tableRemark),
              ),
              DataColumn(
                label: Text(S.of(context).tableCreateAt),
              ),
              DataColumn(
                label: Text(S.of(context).tableUpdateAt),
              ),
            ],
            source: _exchangeModel.exchangeDS,
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

class ExchangeDS extends DataTableSource {
  ExchangeDS();

  ExchangePageState state;
  BuildContext context;

  ExchangeModel _exchangeModel = Get.find<ExchangeModel>();

  @override
  DataRow getRow(int index) {
    if (index >= _exchangeModel.exchangeList.length) {
      return null;
    }

    Exchange exchange = _exchangeModel.exchangeList[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Row(
          children: [
            Text(exchange.yn != 0 ? S.of(context).tableYes : S.of(context).tableNo),
            Switch(value: exchange.yn != 0, onChanged: (value) => state._change_status(exchange.id, value ? 1: 0)),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => state._edit(exchange: exchange)
            )
          ]
        )),
        DataCell(Text(exchange.id.toString() ?? '--')),
        DataCell(Text(exchange.name ?? '--')),
        DataCell(Text(exchange.ico ?? '--')),
        DataCell(Text(exchange.url ?? '--')),
        DataCell(Text(exchange.remark ?? '--')),
        DataCell(Text(exchange.created_at ?? '--')),
        DataCell(Text(exchange.updated_at ?? '--')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _exchangeModel.exchangeList.length;

  @override
  int get selectedRowCount => 0;
}
