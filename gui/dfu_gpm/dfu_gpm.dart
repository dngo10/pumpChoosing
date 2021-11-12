import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/calc/app_controller.dart';
import 'package:my_app/gui/plumbing_info/general_input.dart';

class DfuToGpm extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _DfuToGpm();
  }
}

class _DfuToGpm extends State<DfuToGpm>{

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText("Fixture Unit to GPM"),
            GeneralInput("unit", "Insert Fixture Unit", AppController.inputInfo.fixtureInPutCtrl, "insert fixture unit", AppController.inputInfo.onFixtureInput),
            Row(
              children: [
                const Spacer(),
                DropdownButton(
                  onChanged: (e){
                      AppController.inputInfo.onFlushValveChange(e as String);
                  },
                  value : AppController.inputInfo.flushOrtank,
                  items: AppController.flushOrTank.map<DropdownMenuItem<String>>((e){
                    return DropdownMenuItem<String>(child: Text(e), value: e);
                }).toList()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("equals: ${AppController.inputInfo.gpmConverted} gpm"),
                ElevatedButton(onPressed: (){AppController.inputInfo.inflowCtrl.text = AppController.inputInfo.gpmConverted;}, child: const Text("Use")),
              ],
            )
          ],
        ),
      ),
    );
  }

}