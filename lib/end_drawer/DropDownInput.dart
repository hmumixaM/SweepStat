import 'package:flutter/material.dart';

class DropDownInput extends StatefulWidget {
  final List<String> labelStrings;
  final List values;
  final String hint;
  final initialVal;
  final Function callback;

  const DropDownInput(
      {Key key,
        this.labelStrings,
        this.values,
        this.hint = '',
        this.initialVal,
        this.callback})
      : super(key: key);

  @override
  _DropDownInputState createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  var selectedInput;

  @override
  void initState() {
    super.initState();
    selectedInput = widget.initialVal;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(widget.hint),
      value: selectedInput,
      onChanged: (value) {
        setState(() {
          selectedInput = value;
        });
      },
      items: List.generate(
          widget.labelStrings.length,
              (i) => DropdownMenuItem(
              value: widget.values[i], child: Text(widget.labelStrings[i]))),
      validator: (val) => val == null ? 'Please select a value' : null,
      onSaved: (val) {
        widget.callback(val);
      },
    );
  }
}
