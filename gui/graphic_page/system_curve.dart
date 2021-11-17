import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/calc/app_controller.dart';
import 'package:my_app/calc/pump_data.dart';
import 'package:my_app/gui/graphic_page/system_pump_chart.dart';
import 'package:my_app/gui/plumbing_info/general_input.dart';

class SystemCurve extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SystemCurve();
  }

}

class _SystemCurve extends State<SystemCurve>{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  TitleText("Diameter of impeller"),
                  const Text("-1 means no option", style: TextStyle(fontStyle: FontStyle.italic),),
                  DropdownButton(
                    items: AppController.sewageES.currentPumpSeries.impellerList.map<DropdownMenuItem<Impeller>>(
                      (impeller){
                        return DropdownMenuItem<Impeller>(
                          child: Text(impeller.impellerDia.toStringAsFixed(2) + '"'),
                          value: impeller
                        );
                      }
                    ).toList(),
                    value: AppController.sewageES.impeller,
                    onChanged: (imp){
                      AppController.inputInfo.onImpellerDiaChange(imp as Impeller);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  GeneralInput("ft/s", "pipe out velocity", AppController.inputInfo.pipeOutVelocityCtrl, "Velocity of outlet water", AppController.inputInfo.pipeOutVelocityChange),
                  GeneralInput("min", "Pump Cycling time", AppController.inputInfo.pumpRecyclingCtrl, "Calculated Pump Recycling Time", AppController.inputInfo.onPumpRecyclingChange),
                  GeneralInput("gpm", "pump rate", AppController.inputInfo.pumpRateCtrl, "Pump GPM", AppController.inputInfo.onPumpRateChange),
                ],
              )
            ],
          ),
        ),
        Expanded(child: SystemPumpChart(),)
      ],
    );
  }

}