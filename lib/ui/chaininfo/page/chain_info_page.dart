import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/chain_info.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/ui/chaininfo/page/chain_info_edit_page.dart';
import 'package:lighthouse_admin/ui/chaininfo/viewmodel/chain_info_model.dart';
import 'package:lighthouse_admin/ui/common/widget/button/border_button.dart';

class ChainInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChainInfoPageState();
  }
}

class ChainInfoPageState extends State<ChainInfoPage> with BasePageMixin<ChainInfoPage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  int _rowsPerPage = 10;

  Disposer _chainInfoDisposer;
  ChainInfoModel _chainInfoModel = Get.put(ChainInfoModel());

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
    if (_chainInfoDisposer != null) {
      _chainInfoDisposer();
    }
    super.dispose();
  }

  void initViewModel() {
    _chainInfoModel.initDS(context, this);
    _chainInfoDisposer = _chainInfoModel.addListener(() {
      if (_chainInfoModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_chainInfoModel.isError) {
        closeProgress();
        BotToast.showText(text: _chainInfoModel.viewStateError.message);

      } else if (_chainInfoModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.current.saved);

      } else if (_chainInfoModel.isIdle) {
        closeProgress();
      }
    });
  }

  _query({bool silent = false}) {
    _chainInfoModel.list(silent: silent);
  }

  _edit({ChainInfo chainInfo}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: ChainInfoEditPage(
          chainInfo: chainInfo,
        ),
      ),
    ).then((value) {
      // 添加项目后 刷新一下
      if (value == true && chainInfo == null) {
        _query(silent: true);
      }
    });
  }

  _change_status(id, status) {
    _chainInfoModel.change_status(id, status);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChainInfoModel>(builder: (_) => _buildContent(context));
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
            header: Text(S.of(context).menuChain),
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (int value) {
              setState(() {
                _rowsPerPage = value;
              });
            },
            availableRowsPerPage: <int>[10, 20],
            onPageChanged: (index){},
            columns: <DataColumn>[
              DataColumn(label: Text(S.of(context).tableYn)),
              DataColumn(label: Text(S.of(context).tableId)),
              DataColumn(label: Text(S.of(context).tableName)),
              DataColumn(label: Text(S.of(context).tableSymbol)),
              DataColumn(label: Text(S.of(context).tableChain)),
              DataColumn(label: Text(S.of(context).tableUrl)),
              DataColumn(label: Text(S.of(context).tableTotalMarketValue)),
              DataColumn(label: Text(S.of(context).tableRatio)),
              DataColumn(label: Text(S.of(context).tableTotalSupply)),
              DataColumn(label: Text(S.of(context).tableCoreAlgorithm)),
              DataColumn(label: Text(S.of(context).tableConsensusMechanism)),
              DataColumn(label: Text(S.of(context).tableStartDate)),
              DataColumn(label: Text(S.of(context).tableContent)),
              DataColumn(label: Text(S.of(context).tableCreateAt)),
              DataColumn(label: Text(S.of(context).tableUpdateAt)),
            ],
            source: _chainInfoModel.chainInfoDS,
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

class ChainInfoDS extends DataTableSource {
  ChainInfoDS();

  ChainInfoPageState state;
  BuildContext context;

  ChainInfoModel _chainInfoModel = Get.find<ChainInfoModel>();

  @override
  DataRow getRow(int index) {
    if (index >= _chainInfoModel.chainInfoList.length) {
      return null;
    }

    ChainInfo chainInfo = _chainInfoModel.chainInfoList[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Row(
          children: [
            Text(chainInfo.yn != 0 ? S.of(context).tableYes : S.of(context).tableNo),
            Switch(value: chainInfo.yn != 0, onChanged: (value) => state._change_status(chainInfo.id, value ? 1: 0)),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => state._edit(chainInfo: chainInfo)
            )
          ]
        )),
        DataCell(Text(chainInfo.id.toString() ?? '--')),
        DataCell(Text(chainInfo.name ?? '--')),
        DataCell(Text(chainInfo.symbol ?? '--')),
        DataCell(Text(chainInfo.chain ?? '--')),
        DataCell(Text(chainInfo.url ?? '--')),
        DataCell(Text(chainInfo.total_market_value.toString() ?? '--')),
        DataCell(Text(chainInfo.ratio.toString() ?? '--')),
        DataCell(Text(chainInfo.total_supply.toString() ?? '--')),
        DataCell(Text(chainInfo.core_algorithm ?? '--')),
        DataCell(Text(chainInfo.consensus_mechanism ?? '--')),
        DataCell(Text(chainInfo.start_date ?? '--')),
        DataCell(
            Container(
                constraints: BoxConstraints(maxWidth: 200),
                child: Text(chainInfo.content ?? '--',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)
            )
        ),
        DataCell(Text(chainInfo.created_at ?? '--')),
        DataCell(Text(chainInfo.updated_at ?? '--')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _chainInfoModel.chainInfoList.length;

  @override
  int get selectedRowCount => 0;
}
