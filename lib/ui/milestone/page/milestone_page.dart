import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/milestone.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/ui/common/widget/button/border_button.dart';
import 'package:lighthouse_admin/ui/milestone/page/milestone_edit_page.dart';
import 'package:lighthouse_admin/ui/milestone/viewmodel/milestone_model.dart';

class MilestonePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MilestonePageState();
  }
}

class MilestonePageState extends State<MilestonePage> with BasePageMixin<MilestonePage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  int _rowsPerPage = 20;

  Disposer _friendDisposer;
  MilestoneModel _milestoneModel = Get.put(MilestoneModel());

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
    _milestoneModel.initDS(context, this);
    _friendDisposer = _milestoneModel.addListener(() {
      if (_milestoneModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_milestoneModel.isError) {
        closeProgress();
        BotToast.showText(text: _milestoneModel.viewStateError.message);

      } else if (_milestoneModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.current.saved);

      } else if (_milestoneModel.isIdle) {
        closeProgress();
      }
    });
  }

  _query({bool silent = false}) {
    _milestoneModel.list(silent: silent);
  }

  _edit({Milestone milestone}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: MilestoneEditPage(
          milestone: milestone,
        ),
      ),
    ).then((value) {
      // 添加项目后 刷新一下
      if (value == true && milestone == null) {
        _query(silent: true);
      }
    });
  }

  _change_status(id, status) {
    _milestoneModel.change_status(id, status);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MilestoneModel>(builder: (_) => _buildContent(context));
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
            header: Text(S.of(context).menuFriends),
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (int value) {
              setState(() {
                _rowsPerPage = value;
              });
            },
            availableRowsPerPage: <int>[10, 20, 50],
            onPageChanged: (index){},
            columns: <DataColumn>[
              DataColumn(
                label: Text(S.of(context).tableYn),
              ),
              DataColumn(
                label: Text(S.of(context).tableId),
              ),
              DataColumn(
                label: Text(S.of(context).tableTag),
              ),
              DataColumn(
                label: Text(S.of(context).tableDate),
              ),
              DataColumn(
                label: Text(S.of(context).tableContent),
              ),
              DataColumn(
                label: Text(S.of(context).tableCreateAt),
              ),
              DataColumn(
                label: Text(S.of(context).tableUpdateAt),
              ),
            ],
            source: _milestoneModel.milestoneDS,
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

class MilestoneDS extends DataTableSource {
  MilestoneDS();

  MilestonePageState state;
  BuildContext context;

  MilestoneModel _milestoneModel = Get.find<MilestoneModel>();

  @override
  DataRow getRow(int index) {
    if (index >= _milestoneModel.milestoneList.length) {
      return null;
    }

    Milestone milestone = _milestoneModel.milestoneList[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Row(
          children: [
            Text(milestone.yn != 0 ? S.of(context).tableYes : S.of(context).tableNo),
            Switch(value: milestone.yn != 0, onChanged: (value) => state._change_status(milestone.id, value ? 1: 0)),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => state._edit(milestone: milestone)
            )
          ]
        )),
        DataCell(Text(milestone.id.toString() ?? '--')),
        DataCell(Text(milestone.tag ?? '--')),
        DataCell(Text(milestone.date ?? '--')),
        DataCell(Text(milestone.content ?? '--')),
        DataCell(Text(milestone.created_at ?? '--')),
        DataCell(Text(milestone.updated_at ?? '--')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _milestoneModel.milestoneList.length;

  @override
  int get selectedRowCount => 0;
}
