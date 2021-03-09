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
import 'package:lighthouse_admin/ui/tag/page/tag_edit_page.dart';
import 'package:lighthouse_admin/ui/tag/viewmodel/tag_model.dart';

class TagPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TagPageState();
  }
}

class TagPageState extends State<TagPage> with BasePageMixin<TagPage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  int _rowsPerPage = 10;

  Disposer _friendDisposer;
  TagModel _tagModel = Get.put(TagModel());

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
    _tagModel.initDS(context, this);
    _friendDisposer = _tagModel.addListener(() {
      if (_tagModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_tagModel.isError) {
        closeProgress();
        BotToast.showText(text: _tagModel.viewStateError.message);

      } else if (_tagModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.current.saved);

      } else if (_tagModel.isIdle) {
        closeProgress();
      }
    });
  }

  _query({bool silent = false}) {
    _tagModel.list(silent: silent);
  }

  _edit({Tag tag}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: TagEditPage(
          tag: tag,
        ),
      ),
    ).then((value) {
      // 添加项目后 刷新一下
      if (value == true && tag == null) {
        _query(silent: true);
      }
    });
  }

  _change_status(id, status) {
    _tagModel.change_status(id, status);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TagModel>(builder: (_) => _buildContent(context));
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
                label: Text(S.of(context).tableRemark),
              ),
              DataColumn(
                label: Text(S.of(context).tableCreateAt),
              ),
              DataColumn(
                label: Text(S.of(context).tableUpdateAt),
              ),
            ],
            source: _tagModel.tagDS,
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

class TagDS extends DataTableSource {
  TagDS();

  TagPageState state;
  BuildContext context;

  TagModel _tagModel = Get.find<TagModel>();

  @override
  DataRow getRow(int index) {
    if (index >= _tagModel.tagList.length) {
      return null;
    }

    Tag tag = _tagModel.tagList[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Row(
          children: [
            Text(tag.yn != 0 ? S.of(context).tableYes : S.of(context).tableNo),
            Switch(value: tag.yn != 0, onChanged: (value) => state._change_status(tag.id, value ? 1: 0)),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => state._edit(tag: tag)
            )
          ]
        )),
        DataCell(Text(tag.id.toString() ?? '--')),
        DataCell(Text(tag.name ?? '--')),
        DataCell(Text(tag.remark ?? '--')),
        DataCell(Text(tag.created_at ?? '--')),
        DataCell(Text(tag.updated_at ?? '--')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _tagModel.tagList.length;

  @override
  int get selectedRowCount => 0;
}
