import 'package:flutter/material.dart';

/*
  Validates on formKey.currentState.validate()
  Calls callback with double of input on formKey.currentState.save()
*/
class ValueInput extends StatelessWidget {
  ValueInput(this.text, this.callback, this.value, this.validator, this.prompt);

  final String text, value, prompt;
  final Function callback, validator; // Callback called on save

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
            labelText: text,
            suffixIcon: IconButton(
              onPressed: () {buildAlertDialog(context, text, prompt);},
              icon: Icon(Icons.error),
            )),
        keyboardType: TextInputType.number,
        initialValue: value,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Enter a Value';
          } else {
            try {
              if (this.validator != null) {
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

Future<String> buildAlertDialog(BuildContext context, String value, String prompt) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(value),
            actions: <Widget>[
              Text(prompt, style: TextStyle(fontSize: 20)),
              MaterialButton(
                elevation: 0.5,
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      });
}