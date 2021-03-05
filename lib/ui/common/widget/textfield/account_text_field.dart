import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/res/colors.dart';
import 'package:lighthouse_admin/res/gaps.dart';
import 'package:lighthouse_admin/res/styles.dart';

//登陆注册界面edittext输入框
class AccountTextField extends StatefulWidget {

  final FocusNode focusNode;
  final Function() onTextChanged;
  final Function() onPrefixPressed;
  final String prefixText;
  final TextEditingController controller;

  final Color backgroundColor;
  final InputBorder focusedBorder;
  final InputBorder enabledBorder;

  AccountTextField({
    Key key,
    @required this.controller,
    this.onTextChanged,
    this.focusNode,
    this.prefixText,
    this.onPrefixPressed,
    this.backgroundColor,
    this.focusedBorder,
    this.enabledBorder
  }) : super(key: key);

  @override
  _AccountTextFieldState createState() => _AccountTextFieldState();
}

class _AccountTextFieldState extends State<AccountTextField> {

  bool _isEmptyText() {
    return widget.controller.text == null || widget.controller.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48.0,
        color: widget.backgroundColor ?? Colours.transparent,
        child: TextField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          style: TextStyles.textBlack14,
          keyboardType: TextInputType.numberWithOptions(),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))] ,
          maxLines: 1,
          maxLength: 11,
          decoration: InputDecoration(
            counterText: "",
            hintText: S.of(context).loginAccountHint,
            contentPadding: EdgeInsets.only(top: 20),
            hintStyle: TextStyles.textGray400_w400_14,
            focusedBorder: widget.focusedBorder ?? BorderStyles.underlineInputMain,
            enabledBorder: widget.enabledBorder ?? BorderStyles.underlineInputGray,
            prefixIcon: Container(
                child: FlatButton(
                  padding: EdgeInsets.all(10.0),
                  minWidth: 80,
                  onPressed: null,
                  child: Container(
                      constraints: BoxConstraints(maxWidth: 60),
                      alignment: Alignment.centerLeft,
                      child:Text(widget.prefixText ?? S.of(context).loginAccount, style: TextStyles.textBlack14)
                  ),
                )
            ),
            suffixIcon: !_isEmptyText() ? IconButton(
              iconSize: 20.0,
              icon: Icon(Icons.close, color: Colours.gray_400, size: 20),
              onPressed: () {
                setState(() {
                  widget.controller.text = "";
                  widget.onTextChanged();
                });
              },
            ) : Gaps.empty,
          ),
          onChanged: (text) {
            setState(() {
              widget.onTextChanged();
            });
          },
        )
    );
  }
}
