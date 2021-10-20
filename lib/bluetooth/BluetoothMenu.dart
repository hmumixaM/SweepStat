import 'package:flutter/material.dart';
import 'package:sweep_stat_app/bluetooth/BluetoothManager.dart';

class BluetoothMenu extends StatefulWidget {
  @override
  _BluetoothMenuState createState() => _BluetoothMenuState();
}

class _BluetoothMenuState extends State<BluetoothMenu> {

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await BluetoothManager.scan();
          bool isCapable = await BluetoothManager.isCapable();
          if (isCapable && BluetoothManager.deviceList.isNotEmpty) {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Column(
                  children: [
                    const Text(
                      "Select Your SweepStat",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: ListView(padding: EdgeInsets.all(8), children: [
                      for (var device in BluetoothManager.deviceList)
                        ListTile(
                          leading: BluetoothManager.currentDevice == device
                              ? Icon(Icons.bluetooth_connected,
                                  color: Colors.blue)
                              : null,
                          title: Text(device.name),
                          trailing: IconButton(
                            icon: BluetoothManager.currentDevice == device
                                ? Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  )
                                : Icon(null),
                            onPressed: () {
                              BluetoothManager.disconnect(device);
                              Navigator.pop(context);
                            },
                          ),
                          onTap: () {
                            BluetoothManager.connect(device);
                            Navigator.pop(context);
                          },
                        )
                    ]))
                  ],
                );
              },
            );
          } else if(!isCapable) {
            BluetoothManager.alertDeviceBluetoothIncapable(context);
          } else if(BluetoothManager.deviceList.isEmpty) {
            BluetoothManager.alertNoBluetoothDevicesFound(context);
          }
        },
        icon:
            BluetoothManager.currentDevice != null ? Icon(Icons.bluetooth) : Icon(Icons.bluetooth_disabled));
  }
}
