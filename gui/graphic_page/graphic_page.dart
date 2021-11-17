import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/calc/class_input.dart';
import 'package:my_app/gui/graphic_page/system_curve.dart';
import 'package:provider/provider.dart';

class GraphicPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _GraphicPage();
  }
}

class _GraphicPage extends State<GraphicPage>{
  @override
  Widget build(BuildContext context) {
    return Consumer<InputInfo>(builder: (context, cart, child) => DefaultTabController(
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
            SystemCurve(),
            const Icon(Icons.directions_transit),
            const Icon(Icons.directions_bike),
          ]
        ),
      ),
    )
    );
  }

}