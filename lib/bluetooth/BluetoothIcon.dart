import 'package:flutter/material.dart';

class BluetoothIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {
      //link to bluetooth device page in next iteration
    },
        icon: Icon(Icons.bluetooth_disabled));
  }
}
