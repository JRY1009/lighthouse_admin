import 'package:flutter/material.dart';

import 'from_field_box.dart';

class SelectOptionVO {
  SelectOptionVO({this.value, this.label});

  Object value;
  String label;
}

class FormSelect extends FormFieldBox {
  FormSelect({
    Key key,
    String label,
    Object value,
    ValueChanged onChange,
    FormFieldSetter onSaved,
    List<SelectOptionVO> dataList = const [],
  }) : super(
          key: key,
          label: label,
          builder: (FormFieldBoxBox state) {
            return DropdownButtonFormField<Object>(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(),
              ),
              value: value,
              items: dataList.map((v) {
                return DropdownMenuItem<Object>(
                  value: v.value,
                  child: Text(v.label),
                );
              }).toList(),
              onChanged: (v) {
                value = v;
                if (onChange != null) {
                  onChange(v);
                }
                state.didChange();
              },
              onSaved: (v) {
                if (onSaved != null) {
                  onSaved(v);
                }
              },
            );
          },
        );
}
