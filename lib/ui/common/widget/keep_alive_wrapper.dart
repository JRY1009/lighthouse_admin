import 'package:flutter/material.dart';
import 'package:lighthouse_admin/utils/log_util.dart';

class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({Key key, this.child}) : super(key: key);

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    LogUtil.v('${widget.child.toStringShort()} ==> initState');
    super.initState();
  }

  @override
  void dispose() {
    LogUtil.v('${widget.child.toStringShort()} ==> dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}