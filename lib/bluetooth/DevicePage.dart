import 'package:flutter/material.dart';

class DevicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text("Select Your SweepStat"),
          ),
          ListTile(
            title: const Text("SweepStat 001"),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      )
    );
  }
}