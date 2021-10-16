import 'package:flutter/material.dart';

class BluetoothMenu extends StatefulWidget {
  @override
  _BluetoothMenuState createState() => _BluetoothMenuState();
}

class _BluetoothMenuState extends State<BluetoothMenu> {
  bool connected = false; //removes slash from icon upon successful connection,
  // maybe move to bluetooth handler eventually

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ListView(
              padding: const EdgeInsets.all(8),
              children: [
                const Text("Select Your SweepStat", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                ListTile(
                  title: const Text("SweepStat 001"),
                  onTap: () {
                    setState(() {
                      connected = true;
                    });
                    Navigator.pop(context);
                  },
                )
              ],
            );
          }
      );
    },
        icon: connected ? Icon(Icons.bluetooth) : Icon(Icons.bluetooth_disabled));
  }
}
