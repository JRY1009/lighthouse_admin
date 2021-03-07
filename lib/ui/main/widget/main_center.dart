import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/model/tab_page_data.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/router/routers.dart';
import 'package:lighthouse_admin/ui/common/widget/keep_alive_wrapper.dart';
import 'package:lighthouse_admin/ui/main/viewmodel/main_model.dart';

class MainCenter extends StatefulWidget {
  
  final TabPageData initPage;
  
  MainCenter({
    Key key, 
    this.initPage
  }) : super(key: key);

  @override
  MainCenterState createState() => MainCenterState();
}

class MainCenterState extends State<MainCenter> with TickerProviderStateMixin {

  List<Widget> pages;
  MainModel _mainModel = Get.find<MainModel>();

  @override
  void initState() {
    if (widget.initPage != null) {
      WidgetsBinding.instance.addPostFrameCallback((c) {
        _mainModel.openTab(widget.initPage);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController mainTabController = _mainModel.mainTabController;
    var mainTabPageList = _mainModel.mainTabPageList;
    
    var length = mainTabPageList.length;
    if (length == 0) {
      return Container();
    }

    int index = mainTabPageList.indexWhere((page) => page.id == _mainModel.currentMenuId);
    pages = mainTabPageList.map((TabPageData tabPageData) {
      var page = Routers.mainRouters[tabPageData.url] ?? Container();
      return KeepAliveWrapper(child: page);
    }).toList();

    int tabIndex = mainTabController?.index ?? 0;
    int initialIndex = tabIndex.clamp(0, length - 1);
    mainTabController?.dispose();
    mainTabController = TabController(vsync: this, length: pages.length, initialIndex: initialIndex);
    mainTabController.animateTo(index);
    mainTabController.addListener(() {
      if (mainTabController.indexIsChanging) {
        _mainModel.setCurrentMenuId(mainTabPageList[mainTabController.index].id);
      }
    });

    _mainModel.mainTabController = mainTabController;

    TabBar tabBar = TabBar(
      controller: mainTabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: mainTabPageList.map<Tab>((TabPageData tabPageData) {
        return Tab(
          child: Row(
            children: <Widget>[
              Text(tabPageData.name ?? ''),
              Gaps.hGap4,
              InkWell(
                child: Icon(Icons.close, size: 10),
                onTap: () => _mainModel.closeTab(tabPageData),
              ),
            ],
          )
        );
      }).toList()
    );

    Widget content = Container(
      child: Expanded(
        child: TabBarView(
          controller: mainTabController,
          children: pages,
        ),
      ),
    );

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.theme.primaryColor,
              boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4.0)],
            ),
            child: tabBar,
          ),
          content,
        ],
      ),
    );
  }
}
