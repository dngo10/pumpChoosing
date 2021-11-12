import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/gui/graphic_page/system_pump_chart.dart';

class GraphicPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _GraphicPage();
  }
}

class _GraphicPage extends State<GraphicPage>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          )
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                const Text("Chart"),
                Expanded(child: SystemPumpChart(),)
              ],
            ),
            const Icon(Icons.directions_transit),
            const Icon(Icons.directions_bike),
          ]
        ),
      ),
    );
  }

}