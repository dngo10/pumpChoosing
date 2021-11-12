import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/calc/app_controller.dart';
import 'package:my_app/calc/dfu_gpm.dart';
import 'package:my_app/calc/hazen_william.dart';
import 'package:my_app/calc/pump_data.dart';
import 'package:my_app/calc/sewage_ejector_schedule.dart';

class InputInfo extends ChangeNotifier{
  SewageType waterType =AppController.sewageES.sewageTypeList.first;

  InputInfo(){
    waterLevelToInletHeightCtrl.text = "2";
    AppController.structInfo.alarmToInletHeight = 2;
    lagFloatHeightCtrl.text = "12";
    AppController.structInfo.lagPumpFloatHeight = 12;
    flushOrtank = "tank";
    gpmConverted = "0";
    fuInput = "0";
    materialType = HazenWilliam.hw.keys.first;
    currentPumpSeries = AppController.pumpData.pumpList.first;
    currentPumpModel = AppController.pumpData.pumpList.first.subModels.first;

  }


  TextEditingController inflowCtrl = TextEditingController();
  TextEditingController pipeLengthController = TextEditingController();
  TextEditingController pipeDiameterController = TextEditingController();
  TextEditingController elbow45Controller = TextEditingController();
  TextEditingController elbow90Controller = TextEditingController();
  TextEditingController gateValveController = TextEditingController();
  TextEditingController checkValveController = TextEditingController();

  TextEditingController fixtureInPutCtrl = TextEditingController();

  TextEditingController surfaceThicknessCtrl = TextEditingController();
  TextEditingController basinBaseThicknessCtrl = TextEditingController();
  TextEditingController baseInnerWidthCtrl = TextEditingController();
  TextEditingController basinWallThicknessCtrl = TextEditingController();
  TextEditingController valveboxInnerWidthCtrl = TextEditingController();

  TextEditingController inletSeaLevelCtrl = TextEditingController();
  TextEditingController outletSeaLevelCtrl = TextEditingController();
  TextEditingController finishedSurfaceSeaLevelCtrl = TextEditingController();
  TextEditingController pipeOutSeaLevelCtrl = TextEditingController(); //End of pipe output used for static head
  TextEditingController valveBoxBaseSeaLevelCtrl = TextEditingController(); //Sea level where pipe going out of basin

  TextEditingController lowLevelCtrl = TextEditingController();
  TextEditingController horsePowerCtrl = TextEditingController();
  TextEditingController voltageCtrl = TextEditingController();
  TextEditingController phaseCtrl = TextEditingController();
  TextEditingController ampsCtrl = TextEditingController();
  TextEditingController pumpCableLengthCtrl = TextEditingController();
  TextEditingController minPumpStartCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController tagNumCtrl = TextEditingController();

  TextEditingController usableVolumeCtrl = TextEditingController();
  TextEditingController lagFloatHeightCtrl = TextEditingController();
  TextEditingController waterLevelToInletHeightCtrl = TextEditingController();
  TextEditingController inletToSurfaceHeightCtrl = TextEditingController();
  TextEditingController basinDepthCtrl = TextEditingController();
  TextEditingController totalStructuralDepthCtrl = TextEditingController();
  TextEditingController staticHeadCtrl = TextEditingController();
  TextEditingController outPipeToFinishedSurfaceCtrl = TextEditingController();
  TextEditingController valveBoxDepthCtrl = TextEditingController();

  TextEditingController hazenCoEfficientCtrl = TextEditingController();
  TextEditingController fittingsToLengthCtrl = TextEditingController();
  TextEditingController totalLengthCtrl = TextEditingController();
  TextEditingController usableVolumeHeightCtrl = TextEditingController();
  TextEditingController pipeOutVelocityCtrl = TextEditingController();
  TextEditingController pumpRecyclingCtrl = TextEditingController();

  String materialType = "";
  String flushOrtank = "";
  String gpmConverted = "";

  String fuInput = "0";
  String basinShape = "square";


  Pump currentPumpSeries = AppController.pumpData.pumpList.first;
  PumpElectricDetails currentPumpModel = AppController.pumpData.pumpList.first.subModels.first;

  NumberFormat nf = NumberFormat("######.0#");
  
  void onInflowchange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.inflow = num;
    AppController.structInfo.useableVolume = 4 * num;
    AppController.inputInfo.usableVolumeCtrl.text = nf.format(num * 4);
  }

  void onFixtureInput(String value){
    fuInput = value;
    double num = _strToDouble(value);
    if(flushOrtank == "flush"){
      gpmConverted = nf.format(FuGpm.flushToGpm(num));
      notifyListeners();
    }else if(flushOrtank == "tank"){
      gpmConverted = nf.format(FuGpm.tankToGpm(num));
      notifyListeners();
    }
  }

  void onFlushValveChange(String value){
    flushOrtank = value;
    double num = _strToDouble(fuInput);
    if(value == "flush"){
      gpmConverted = nf.format(FuGpm.flushToGpm(num));
      notifyListeners();
    }else if(value == "tank"){
      gpmConverted = nf.format(FuGpm.tankToGpm(num));
      notifyListeners();
    }
  }

  void onMaterialTypeChange(String value){
    HazenWilliam.hw.forEach((key, v) {
      if(key.trim() == value.trim()){
        AppController.sewageCalc.material = value;
        AppController.sewageCalc.C = HazenWilliam.hw[key]!;
        hazenCoEfficientCtrl.text = nf.format(AppController.sewageCalc.C);
        notifyListeners();
      }
    });
  }

  void onBasinShapeChange(String value){
    basinShape = value;
    AppController.structInfo.baseShape = value;
    notifyListeners();
  }

  void onPipeLengthChange(String value){
    double num = _strToDouble(value);
    AppController.sewageCalc.pipeLength = num;
  }

  void onPipeDiameterChange(String value){
    double num = _strToDouble(value);
    AppController.sewageCalc.diameter = num;
  }

  void onElbow45Change(String value){
    double num = _strToDouble(value);
    AppController.sewageCalc.numOf45Elbow = num;
  }

  void onElbow90Change(String value){
    double num = _strToDouble(value);
    AppController.sewageCalc.numOf90Elbow = num;
  }

  void onGateValveChange(String value){
    double num = _strToDouble(value);
    AppController.sewageCalc.numofGateValve = num;
  }

  void onCheckValveChange(String value){
    double num = _strToDouble(value);
    AppController.sewageCalc.numofCheckValve = num;
  }

  void onSurfaceThicknessChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.surfaceThickness = num;
  }

  void onBasinBaseThicknessChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.baseThickness = num;
  }

  void onInnerDiameterChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.baseInnerDiameterW = num;
  }

  void onBasinWallThicknessChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.baseWallThickness = num;
  }

  void onValveboxInnerWidthChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.valveBoxW = num;
  }

  void onInletSeaLevelChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.inletSeaLevel = num;
  }

  void onPipeEndSeaLevelChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.pipeOutSeaLevel = num;
  }

  void onSurfaceSeaLevelChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.surfaceSeaLevel = num;
  }

  void onOutPipeToSurfaceChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.pipeOutSeaLevel = num;
  }

  void onValveBoxSeaLevelChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.valBoxSeaLevel = num;
  }

  void onPipeOutletSeaLevelChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.pipeOutLetSeaLevel = num;
  }

  void onLowLevelChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.lowLevel = num;
  }

  void onSeriesBoxChange(Pump value){
    currentPumpSeries =value;
    currentPumpModel  = value.subModels.first;
    lowLevelCtrl.text = nf.format(currentPumpSeries.lowlevel);
    AppController.structInfo.lowLevel = currentPumpSeries.lowlevel;
    onSubModelBoxChange(currentPumpModel);
    //notifyListeners(); //onSubModelChange will call notifyListeners
  }

  void onSubModelBoxChange(PumpElectricDetails value){
    currentPumpModel = value;
    horsePowerCtrl.text = value.hp;
    voltageCtrl.text = value.voltage;
    phaseCtrl.text = value.phase;
    ampsCtrl.text = value.amps;
    AppController.sewageES.model = currentPumpModel.model;
    AppController.sewageES.bHousePower = currentPumpModel.hp;
    AppController.sewageES.volTage = currentPumpModel.voltage;
    AppController.sewageES.phase = currentPumpModel.phase;
    AppController.sewageES.amps = currentPumpModel.amps;
    notifyListeners();
  }

  void onHorsePowerChange(String value){
    AppController.sewageES.bHousePower = value;
  }

  void onVoltageChange(String value){
    AppController.sewageES.volTage = value;
  }

  void onPhaseChange(String value){
    AppController.sewageES.phase = value;
  }

  void onAmpsChange(String value){
    AppController.sewageES.amps = value;
  }

  void onPumpCableLengthChange(String value){
    double num = _strToDouble(value);
    AppController.sewageES.cableLength = num;
  }

  void onLocationChange(String value){
    AppController.sewageES.location = value;
  }

  void onWaterTypeChange(SewageType type){
    AppController.sewageES.sewageType = type;
    waterType = type;
    notifyListeners();
  }

  void onTagNumChange(String value){
    AppController.sewageES.tagNum = value;
  }

  void onHazemWilliamCofficientChange(String value){
    double num  = _strToDouble(value);
    AppController.sewageCalc.C = num;
  }

  void onFittingsEquivToLengthChange(String value){
    double num = _strToDouble(value);
    AppController.sewageCalc.equivalentPipeLength = num;
  }

  void onTotalPipeLengthChange(String value){
    double num = _strToDouble(value);
    AppController.sewageCalc.totalLength = num;
  }

  void onUseableVolumeChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.useableVolume = num;
  }

  void onUseableVolumeHeightChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.useableVolumeH = num;
  }

  void onLagToWaterLevelChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.lagPumpFloatHeight = num;
  }

  void onWaterLevelToInlet(String value){
    double num = _strToDouble(value);
    AppController.structInfo.alarmToInletHeight = num;
  }

  void onInlettoSuraceHeightChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.inletToSurface = num;
  }

  void onDepthBasinChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.basinDepth = num;
  }

  void onTotalStructureHeightChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.structureHeight = num;
  }

  void onStaticHeadChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.staticHead = num;
  }

  void onValveBoxDepthChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.valveBoxH = num;
  }

  void onMinPumpStartChange(String value){
    double num = _strToDouble(value);
    AppController.sewageES.minPumpstart = num;
  }

  void onPumpRecyclingChange(String value){
    double num = _strToDouble(value);
    AppController.sewageES.calculatedPumpStart = num;
  }

  void pipeOutVelocityChange(String value){
    double num = _strToDouble(value);
    AppController.sewageES.pipeOutVelocity = num;
  }

  double _strToDouble(String value){
    double? num = double.tryParse(value);
    if(num != null) {
      return num;
    } else{
      return 0;
    }
  }


}