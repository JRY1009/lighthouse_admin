import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/user.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/ui/common/widget/button/border_button.dart';
import 'package:lighthouse_admin/ui/user/viewmodel/user_model.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserPageState();
  }
}

class UserPageState extends State<UserPage> with BasePageMixin<UserPage> {

  final GlobalKey<PaginatedDataTableState> tableKey = GlobalKey<PaginatedDataTableState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User formData = User();
  
  int _rowsPerPage = 10;

  Disposer _userDisposer;
  UserModel _userModel = Get.put(UserModel());

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
    if (_userDisposer != null) {
      _userDisposer();
    }
    super.dispose();
  }

  void initViewModel() {
    _userModel.initDS(context, this);
    _userModel.page_size = _rowsPerPage;
    _userDisposer = _userModel.addListener(() {
      if (_userModel.isBusy) {
        showProgress(content: S.current.loading);

      } else if (_userModel.isError) {
        closeProgress();
        BotToast.showText(text: _userModel.viewStateError.message);

      } else if (_userModel.isSuccess) {
        closeProgress();
        BotToast.showText(text: S.current.saved);

      } else if (_userModel.isIdle) {
        closeProgress();
      }
    });
  }

  _query({bool silent = false}) {
    formKey.currentState.save();

    _userModel.list(
        phone: formData.phone ?? '',
        nick_name: formData.nick_name ?? '',
        silent: silent);
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserModel>(builder: (_) => _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    var formBar = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            width: 200,
            child: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: S.of(context).tablePhone,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
              controller: TextEditingController(text: formData.phone),
              onSaved: (v) {
                formData.phone = v;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            width: 200,
            child: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: S.of(context).tableNickName,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
              controller: TextEditingController(text: formData.nick_name),
              onSaved: (v) {
                formData.nick_name = v;
              },
            ),
          ),
        ],
      ),
    );

    ButtonBar buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        Gaps.hGap5,
        BorderButton(
            width: 80,
            height: 40,
            text: S.of(context).query,
            onPressed: () {
              if (_userModel.page_num <= 1) {
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
            header: Text(S.of(context).menuAccount),
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (int value) {
              _rowsPerPage = value;
              _userModel.page_size = value;
              if (_userModel.page_num <= 1) {
                _query();
              } else {
                tableKey.currentState.pageTo(0);
              }
            },
            availableRowsPerPage: <int>[5, 10, 20],
            onPageChanged: (firstRowIndex){
              _userModel.page_num = (firstRowIndex / _userModel.page_size).toInt() + 1;
              _query();
            },
            columns: <DataColumn>[
              DataColumn(label: Text(S.of(context).tableYn)),
              DataColumn(label: Text(S.of(context).tableId)),
              DataColumn(label: Text(S.of(context).tableEmail)),
              DataColumn(label: Text(S.of(context).tablePhone)),
              DataColumn(label: Text(S.of(context).tableNickName)),
              DataColumn(label: Text(S.of(context).tableHeadIco)),
              DataColumn(label: Text(S.of(context).tablePwd)),
              DataColumn(label: Text(S.of(context).tableRemark)),
              DataColumn(label: Text(S.of(context).tableCreateAt)),
              DataColumn(label: Text(S.of(context).tableUpdateAt)),
            ],
            source: _userModel.userDS,
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
          formBar,
          buttonBar,
          Expanded(
            child: table,
          ),
        ],
      ),
    );
  }
}

class UserDS extends DataTableSource {
  UserDS();

  UserPageState state;
  BuildContext context;

  UserModel _userModel = Get.find<UserModel>();

  @override
  DataRow getRow(int index) {
    if (index >= _userModel.userList.length) {
      return null;
    }

    User user = _userModel.userList[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Row(
          children: [
            Text(user.yn != 0 ? S.of(context).tableYes : S.of(context).tableNo),
          ]
        )),
        DataCell(Text(user.id.toString() ?? '--')),
        DataCell(Text(user.email ?? '--')),
        DataCell(Text(user.phone ?? '--')),
        DataCell(Text(user.nick_name ?? '--')),
        DataCell(
            Container(
                constraints: BoxConstraints(maxWidth: 200),
                child: Text(user.head_ico ?? '--',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)
            )
        ),
        DataCell(Text(user.password ?? '--')),
        DataCell(Text(user.remark ?? '--')),
        DataCell(Text(user.created_at ?? '--')),
        DataCell(Text(user.updated_at ?? '--')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userModel.count;

  @override
  int get selectedRowCount => 0;
}
