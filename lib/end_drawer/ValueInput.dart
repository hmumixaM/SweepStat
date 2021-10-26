import 'package:flutter/material.dart';

/*
  Validates on formKey.currentState.validate()
  Calls callback with double of input on formKey.currentState.save()
*/
class ValueInput extends StatelessWidget {
  ValueInput(this.text, this.callback, this.value, this.validator);

  final String text,
      value; // Text is displayed name, units is the displayed unit val at end
  final Function callback, validator; // Callback called on save

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(labelText: text),
        keyboardType: TextInputType.number,
        initialValue: value,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Enter a Value';
          } else {
            try {
              if (this.validator != null){
                return this.validator(value);
              } else {
                double.parse(value);
                return null;
              }
            } catch (e) {
              return 'Enter a valid number';
            }
          }
        },
        onSaved: (String val) {
          callback(double.parse(val));
        });
  }
}