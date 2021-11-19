import 'package:flutter/material.dart';
import 'package:my_app/calc/app_controller.dart';
import 'package:my_app/gui/graphic_page/pump_flow_rate.dart';
import 'package:my_app/gui/plumbing_info/general_input.dart';

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

        SizedBox(
          width: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GeneralInput( "min",
                            "Minimum Pump Start",
                            AppController.inputInfo.minPumpStartCtrl ,
                            "minimum between pump starts",
                            AppController.inputInfo.onMinPumpStartChange
                            ),
              ElevatedButton(
                onPressed: (){ AppController.inputInfo.onMinPumpStartChange2(); },
                child: const Icon(Icons.refresh)
              )
            ],
          ),
        ),
        Expanded(child: PumpFlowRate())
      ],
    );
  }

}