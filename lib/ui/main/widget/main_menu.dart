import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/ui/common/widget/treemenu/menu_data.dart';
import 'package:lighthouse_admin/ui/common/widget/treemenu/tree_data.dart';
import 'package:lighthouse_admin/ui/common/widget/treemenu/tree_util.dart';
import 'package:lighthouse_admin/ui/main/viewmodel/main_model.dart';
import 'package:lighthouse_admin/utils/object_util.dart';
import 'package:lighthouse_admin/utils/screen_util.dart';

class MainMenu extends StatefulWidget {
  MainMenu({
    Key key,
    this.onClick,
  }) : super(key: key);
  final Function onClick;

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  MainModel _mainModel = Get.find<MainModel>();

  bool _expanded;
  List<MenuData> _listMenuData = [];

  Map<String, IconData> iconMap = {
    '101': Icons.person,
    '102': Icons.money,
    '103': Icons.add_shopping_cart,
    '104': Icons.link,
    '105': Icons.military_tech,
    '106': Icons.show_chart,
    '201': Icons.map,
    '202': Icons.local_fire_department,
    '107': Icons.sms,
    '108': Icons.tag,
  };

  @override
  void initState() {
    super.initState();
    _listMenuData = [
      MenuData(id: '101', checked: true, name: S.current.menuAccount, url:''),
      MenuData(id: '102', checked: false, name: S.current.menuChain, url:''),
      MenuData(id: '103', checked: false, name: S.current.menuExchange, url:''),
      MenuData(id: '104', checked: false, name: S.current.menuFriends, url:''),
      MenuData(id: '105', checked: false, name: S.current.menuMileStone, url:''),
      MenuData(id: '106', checked: false, name: S.current.menuQuote, url:''),
      MenuData(id: '201', parentId: '106', checked: false, name: S.current.menuQuoteGlobal, url:''),
      MenuData(id: '202', parentId: '106', checked: false, name: S.current.menuQuoteTreemap, url:''),
      MenuData(id: '107', checked: false, name: S.current.menuSms, url:''),
      MenuData(id: '108', checked: false, name: S.current.menuTag, url:''),
    ];

    _mainModel.currentMenuId ??= TreeUtil.getChecked(_listMenuData)?.id;
  }

  @override
  Widget build(BuildContext context) {

    _expanded ??= ScreenUtil.instance().screenWidth > 1000.0;

    Widget menuHead = ListTile(
      title: Icon(Icons.menu),
      onTap: () => setState(() { _expanded = !_expanded; }),
    );

    List<Widget> menuBody = _getMenuList(TreeUtil.toTreeVOList(_listMenuData));

    return SizedBox(
      width: _expanded ? 240 : 60,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
        ),
        child: ListView(
            children: [
              menuHead,
              ...menuBody
            ]
        )
      ),
    );
  }

  bool _isCurrentMenu(List<TreeVO<MenuData>> data) {
    for (var treeVO in data) {
      if (treeVO.children != null && treeVO.children.length > 0) {
        return _isCurrentMenu(treeVO.children);
      }

      return _mainModel.currentMenuId == treeVO.data.id;
    }
    return false;
  }

  List<Widget> _getMenuList(List<TreeVO<MenuData>> data) {
    if (data == null) {
      return [];
    }
    List<Widget> menuList = data.map<Widget>((TreeVO<MenuData> treeVO) {
      IconData iconData = iconMap[treeVO.data.id];
      String name = treeVO.data.name ?? '';

      if (!ObjectUtil.isEmptyList(treeVO.children)) {
        return ExpansionTile(
          initiallyExpanded: _isCurrentMenu(treeVO.children),
          leading: Icon(iconData),
          trailing: _expanded ? null : Gaps.empty,
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          children: _getMenuList(treeVO.children),
          title: Text(_expanded ? name : ''),
        );

      } else {
        return ListTile(
          tileColor: _mainModel.currentMenuId == treeVO.data.id ? Colors.blue.shade100 : Colors.white,
          leading: Icon(iconData),
          title: Text(_expanded ? name : ''),
          onTap: () {
            if (_mainModel.currentMenuId != treeVO.data.id) {
              _mainModel.currentMenuId = treeVO.data.id;
              setState(() {});
            }
          },
        );
      }
    }).toList();

    return menuList;
  }
}
