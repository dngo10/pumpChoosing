import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/calc/app_controller.dart';
import 'package:my_app/calc/hazen_william.dart';

class PipeMaterial extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _PipeMaterial();
  }
  
}

class _PipeMaterial extends State<PipeMaterial>{
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: DropdownButton(items: HazenWilliam.hw.keys.map((key){
        return DropdownMenuItem(
          child: SizedBox(width: 175, child: Text(key)),
          value: key  
        );
      }).toList(),
      onChanged: (val){
        AppController.inputInfo.materialType = val as String;
        AppController.inputInfo.onMaterialTypeChange(val);
      },
      value: AppController.inputInfo.materialType
      ),
    );
  }
}