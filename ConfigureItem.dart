import 'package:flutter/material.dart';
import 'ConfigureFileTab.dart';
import 'package:sweep_stat_app/end_drawer/EndDrawerPage.dart';

class Config {
  String name;
  int initialV;
  int vertexV;
  int finalV;

  Config({this.name, this.initialV, this.finalV, this.vertexV});
}


class ConfigureItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfigureItem();
  }
}

class _ConfigureItem extends State<ConfigureItem> {
  final List<String> nameList = <String>['Configuration 1', 'Configuration 2', 'Configuration 3'];
  final List<int> initialVList = <int>[1, 2, 3];
  final List<int> vertexVList = <int>[4, 5, 6];
  final List<int> finalVList = <int>[7, 8, 9];
  List<Config> ConfigList = <Config>[];
  //Config test = new Config(name:"test", initialV:1, vertexV:2, finalV:3);
  @override
  Widget build(BuildContext context) {

    for (int i=0; i<nameList.length; i++) {
      Config newConfig = new Config(
        name: nameList[i],
        initialV: initialVList[i],
        vertexV: vertexVList[i],
        finalV: finalVList[i],
      );
      ConfigList.add(newConfig);
    };

    return ExpansionTile(
      initiallyExpanded: true,
      title: Text('Configurations',
        textScaleFactor: 1.25,),

      children: [
          ListView.builder(
            shrinkWrap: true,
          itemCount: ConfigList.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildConfigList(ConfigList[index]);
          },
          ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text('Show All'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfigureFileTab(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildConfigList(Config items) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Text(items.name),
      ),
      subtitle: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
        child: Text("Initial Voltage: "+items.initialV.toString()+", "+"Vertex Voltage: "+items.vertexV.toString()+", "+"Final Voltage: "+items.finalV.toString(),
            style: TextStyle(height: 1.5)),
      ),
      onTap: () { Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EndDrawerPage(
              initialV: items.initialV,
              vertexV: items.vertexV,
              finalV: items.finalV,
            ),
          )
      );
      },
    );
  }




}

