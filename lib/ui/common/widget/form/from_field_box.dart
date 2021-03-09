import 'package:flutter/material.dart';
import 'package:lighthouse_admin/utils/screen_util.dart';

class FormFieldBox extends StatefulWidget {
  final String label;
  final double width;
  final double labelWidth;
  final Function builder;

  FormFieldBox({
    Key key,
    this.label,
    this.builder,
    this.width,
    this.labelWidth,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormFieldBoxBox();
}

class FormFieldBoxBox extends State<FormFieldBox> {
  didChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool wrap_content = ScreenUtil.instance().screenWidth > 1000.0;

    if (!wrap_content) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: widget.labelWidth ?? 80,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  child: Text(widget.label),
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
            Expanded(
              child: widget.builder(this),
            )
          ],
        ),
      );
    } else {
      double boxWidth = (widget.width ?? 300) - (widget.labelWidth ?? 80);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: UnconstrainedBox(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: widget.labelWidth ?? 80,
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Align(
                    child: Text(widget.label),
                    alignment: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                width: boxWidth,
                child: widget.builder(this),
              ),
            ],
          ),
        ),
      );
    }
  }
}
