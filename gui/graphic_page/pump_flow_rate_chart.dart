import 'package:flutter/material.dart';
import 'package:my_app/gui/graphic_page/pump_flow_rate.dart';

class PumpFlowRateChart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _PumpFlowRateChart();
  }
}

class _PumpFlowRateChart extends State<PumpFlowRateChart>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: PumpFlowRate())
      ],
    );
  }

}