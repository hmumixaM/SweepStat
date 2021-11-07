import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'SweepStatBTConnection.dart';
import '../screen/StateWidget.dart';

FlutterBlue flutterBlue = FlutterBlue.instance;

class BluetoothMenu extends StatefulWidget {
  @override
  _BluetoothMenuState createState() => _BluetoothMenuState();
}

class _BluetoothMenuState extends State<BluetoothMenu> {
  @override
  void initState() {
    FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
    super.initState();
  }

  @override
  void dispose() {
    FlutterBlue.instance.stopScan();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        bluetooth(context);
      },
      icon: Icon(Icons.bluetooth),
    );
  }

  Future<void> bluetooth(BuildContext context) async {
    if (BackEnd.of(context).getExp() != null &&
        BackEnd.of(context).getExp().isExperimentInProgress) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Experiment in progress')));
      return;
    } else if (BackEnd.of(context).getBT() != null) {
      await BackEnd.of(context).getBT().endConnection();
      BackEnd.of(context).newBluetoothConnection(null);
    }

    BluetoothDevice device = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return buildAlertDialog(context);
        }) as BluetoothDevice;
    if (device == null) return;
    try {
      await device.connect();
      SweepStatBTConnection newCon =
          await SweepStatBTConnection.createSweepBTConnection(device,
              () => BackEnd.of(context).getProcess().onBTDisconnect(context));
      BackEnd.of(context).newBluetoothConnection(newCon);
      if (newCon == null) {
        print('null conn');
        return;
      }
      BackEnd.of(context).newBluetoothConnection(newCon);
      BackEnd.of(context).getProcess().context = context;
      await BackEnd.of(context)
          .getBT()
          .addNotifyListener(BackEnd.of(context).getProcess().acceptBTData);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('BT Error: Did you select the correct device?')));
    }
  }

  Widget buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Bluetooth Devices",
        style: TextStyle(fontSize: 22),
        textAlign: TextAlign.center,
      ),
      content: Scaffold(
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: () =>
                FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(),
                  StreamBuilder<List<dynamic>>(
                    stream: FlutterBlue.instance.scanResults,
                    // stream: null,
                    initialData: [],
                    builder: (c, snapshot) => Column(
                      children: snapshot.data.map((r) {
                        if (r.device.name.isNotEmpty) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                r.device.name,
                                textAlign: TextAlign.center,
                              ),
                              onTap: () async {
                                Navigator.pop(context, r.device);
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: StreamBuilder<bool>(
            stream: FlutterBlue.instance.isScanning,
            initialData: false,
            builder: (c, snapshot) {
              if (snapshot.data) {
                return FloatingActionButton(
                  child: Icon(Icons.stop),
                  onPressed: () => FlutterBlue.instance.stopScan(),
                  backgroundColor: Colors.red,
                );
              } else {
                return FloatingActionButton(
                    child: Icon(Icons.search),
                    onPressed: () => FlutterBlue.instance
                        .startScan(timeout: Duration(seconds: 4)));
              }
            },
          )),
    );
  }
}
