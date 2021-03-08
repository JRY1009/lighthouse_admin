import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/friend.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/ui/common/widget/button/border_button.dart';
import 'package:lighthouse_admin/ui/friend/viewmodel/friend_model.dart';

class FriendPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FriendPageState();
  }
}

class FriendPageState extends State<FriendPage> with BasePageMixin<FriendPage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  int _rowsPerPage = 10;


  FriendModel _friendModel = Get.put(FriendModel());

  @override
  void initState() {
    super.initState();

    initViewModel();

    WidgetsBinding.instance.addPostFrameCallback((c) {
      _query();
    });
  }


  void initViewModel() {
    _friendModel.initDS(context, this);
    _friendModel.addListener(() {
      if (_friendModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_friendModel.isError) {
        closeProgress();
        BotToast.showText(text: _friendModel.viewStateError.message);

      } else if (_friendModel.isSuccess) {
        closeProgress();
      }
    });
  }

  _reset() {
  }

  _query() {
    _friendModel.list();
  }

  _edit({Friend friend}) {
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendModel>(builder: (_) => _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {

    ButtonBar buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        BorderButton(width: 80, height: 40, text: S.of(context).query, onPressed: () => _query()),
        BorderButton(width: 80, height: 40, text: S.of(context).reset, onPressed: () => _reset()),
        BorderButton(width: 80, height: 40, text: S.of(context).edit, onPressed: () => _edit())
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
                label: Text(S.of(context).tableId),
              ),
              DataColumn(
                label: Text(S.of(context).tableName),
              ),
              DataColumn(
                label: Text(S.of(context).tableCategory),
              ),
              DataColumn(
                label: Text(S.of(context).tableUrl),
              ),
              DataColumn(
                label: Text(S.of(context).tableCreateAt),
              ),
              DataColumn(
                label: Text(S.of(context).tableUpdateAt),
              ),
            ],
            source: _friendModel.friendDS,
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

class FriendDS extends DataTableSource {
  FriendDS();

  FriendPageState state;
  BuildContext context;

  FriendModel _friendModel = Get.find<FriendModel>();

  @override
  DataRow getRow(int index) {
    if (index >= _friendModel.friendList.length) {
      return null;
    }

    Friend friend = _friendModel.friendList[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(friend.id.toString() ?? '--')),
        DataCell(Text(friend.name ?? '--')),
        DataCell(Text(friend.category.toString() ?? '--')),
        DataCell(Text(friend.url ?? '--')),
        DataCell(Text(friend.created_at ?? '--')),
        DataCell(Text(friend.updated_at ?? '--')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _friendModel.friendList.length;

  @override
  int get selectedRowCount => 0;
}
