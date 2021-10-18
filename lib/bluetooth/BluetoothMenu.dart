import 'package:flutter/material.dart';
import 'package:sweep_stat_app/bluetooth/BluetoothConnectionSim.dart';
import 'package:sweep_stat_app/bluetooth/BluetoothManager.dart';

class BluetoothMenu extends StatefulWidget {
  @override
  _BluetoothMenuState createState() => _BluetoothMenuState();
}

class _BluetoothMenuState extends State<BluetoothMenu> {
  bool connected = false; //removes slash from icon upon successful connection,
  // maybe move to bluetooth handler eventually

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Column(
                children: [
                  const Text(
                    "Select Your SweepStat",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: ListView(padding: EdgeInsets.all(8), children: [
                    for (var e in BluetoothManager.tempList)
                      ListTile(
                        leading: e.connected
                            ? Icon(Icons.bluetooth_connected, color: Colors.blue)
                            : null,
                        title: Text(e.name),
                        trailing: IconButton(
                          icon: e.connected ? Icon(Icons.close, color: Colors.red,) : Icon(null),
                          onPressed: () {
                            BluetoothManager.disconnect(e);
                            setState(() {
                              connected = false;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        onTap: () {
                          setState(() {
                            connected = true;
                          });
                          BluetoothManager.connect(e);
                          Navigator.pop(context);
                        },
                      )
                  ]))
                ],
              );
            },
          );
        },
        icon:
            connected ? Icon(Icons.bluetooth) : Icon(Icons.bluetooth_disabled));
  }
}
