
import 'package:flutter/material.dart';
import 'package:lighthouse_admin/utils/date_util.dart';

import 'from_field_box.dart';


class FormSelectDate extends FormFieldBox {
  FormSelectDate({
    Key key,
    String value,
    String label,
    ValueChanged onChange,
    FormFieldSetter onSaved,
    BuildContext context,
  }) : super(
          key: key,
          label: label,
          builder: (FormFieldBoxBox state) {
            return TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: value),
              onChanged: (v) {
                if (onChange != null) {
                  onChange(v);
                }
              },
              onTap: () async {
                final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: DateUtil.getDateTime(value),
                  firstDate: DateTime(2000, 1),
                  lastDate: DateTime(2101),
                );

                if (picked != null) {
                  value = DateUtil.formatDate(picked, format: DataFormats.y_mo_d);
                  state.didChange();
                }
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
