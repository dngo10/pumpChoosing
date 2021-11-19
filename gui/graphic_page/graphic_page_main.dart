import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/calc/app_controller.dart';
import 'package:my_app/calc/class_input.dart';
import 'package:my_app/gui/graphic_page/pump_flow_rate_chart.dart';
import 'package:my_app/gui/graphic_page/system_curve.dart';
import 'package:provider/provider.dart';

class GraphicPage extends StatefulWidget{
  const GraphicPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _GraphicPage();
  }
}

class _GraphicPage extends State<GraphicPage>{
  @override
  Widget build(BuildContext context) {
    return Consumer<InputInfo>(builder: (context, cart, child) => DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.show_chart)),
              Tab(icon: Icon(Icons.multiline_chart)),
            ],
          )
        ),
        body: TabBarView(
          children: [
            PumpFlowRateChart(),
            SystemCurve(key: AppController.key),
          ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: const Icon(Icons.exit_to_app),
        ),
      ),
    )
    );
  }

}