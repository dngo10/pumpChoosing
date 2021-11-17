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
    waterLevelToInletHeightCtrl.text = nf.format(AppController.structInfo.alarmToInletHeight);
    lagFloatHeightCtrl.text = nf.format(AppController.structInfo.lagPumpFloatHeight);
    hazenCoEfficientCtrl.text = nf.format(AppController.sewageCalc.C);
    flushOrtank = "tank";
    gpmConverted = "0";
    fuInput = "0";
    //materialType = HazenWilliam.hw.keys.first;
    lowLevelCtrl.text = nf.format(AppController.sewageES.currentPumpSeries.lowlevel);
    horsePowerCtrl.text = AppController.sewageES.currentPumpModel.hp;
    voltageCtrl.text = AppController.sewageES.currentPumpModel.voltage;
    ampsCtrl.text = AppController.sewageES.currentPumpModel.amps;
    phaseCtrl.text = AppController.sewageES.currentPumpModel.phase;
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
  TextEditingController basinOutSeaLevelCtrl = TextEditingController(); //End of pipe output used for static head
  TextEditingController valveBoxBaseSeaLevelCtrl = TextEditingController();

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
  TextEditingController pumpRateCtrl = TextEditingController();

  //String materialType = "";
  String flushOrtank = "";
  String gpmConverted = "";

  String fuInput = "0";
  //String basinShape = "square";




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
    AppController.structInfo.pipeOutToSurfaceHeight = num;
  }

  void onValveBoxSeaLevelChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.valBoxSeaLevel = num;
  }

  void onBasinOutletSeaLevelChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.basinOutLetSeaLevel = num;
  }

  void onLowLevelChange(String value){
    double num = _strToDouble(value);
    AppController.structInfo.lowLevel = num;
  }

  void onSeriesBoxChange(Pump value){
    AppController.sewageES.currentPumpSeries =value;
    lowLevelCtrl.text = nf.format(AppController.sewageES.currentPumpSeries.lowlevel);
    onSubModelBoxChange(AppController.sewageES.currentPumpSeries.subModels.first);
    onImpellerDiaChange(AppController.sewageES.currentPumpSeries.impellerList.first);
    //notifyListeners(); //onSubModelChange will call notifyListeners
  }

  void onSubModelBoxChange(PumpElectricDetails value){
    AppController.sewageES.currentPumpModel = value;
    horsePowerCtrl.text = value.hp;
    voltageCtrl.text = value.voltage;
    phaseCtrl.text = value.phase;
    ampsCtrl.text = value.amps;
    AppController.sewageES.currentPumpModel = value;
    notifyListeners();
  }

  void onImpellerDiaChange(Impeller imp){
    AppController.sewageES.impeller = imp;
    AppController.sewageES.reCalculate();
    pipeOutVelocityCtrl.text = nf.format(AppController.sewageES.pipeOutVelocity);
    pumpRecyclingCtrl.text = nf.format(AppController.sewageES.calculatedPumpStart);
    pumpRateCtrl.text = nf.format(AppController.sewageES.pumpRate);
    notifyListeners();
  }

  void onHorsePowerChange(String value){
    AppController.sewageES.currentPumpModel.hp = value;
  }

  void onVoltageChange(String value){
    AppController.sewageES.currentPumpModel.voltage = value;
  }

  void onPhaseChange(String value){
    AppController.sewageES.currentPumpModel.phase = value;
  }

  void onAmpsChange(String value){
    AppController.sewageES.currentPumpModel.amps = value;
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

  void onPumpRateChange(String value){
    double num = _strToDouble(value);
    AppController.sewageES.pumpRate = num;
  }

  void onRecalculateButtonPress(){
    reCalculateData();
    notifyListeners();
  }

  double _strToDouble(String value){
    double? num = double.tryParse(value);
    if(num != null) {
      return num;
    } else{
      return 0;
    }
  }

  void reCalculateData(){
    preData();

    onInflowchange(inflowCtrl.text);
    onPipeLengthChange(pipeLengthController.text);
    onPipeDiameterChange(pipeDiameterController.text);
    onElbow45Change(elbow45Controller.text);
    onElbow90Change(elbow90Controller.text);
    onGateValveChange(gateValveController.text);
    onCheckValveChange(checkValveController.text);
    onSurfaceThicknessChange(surfaceThicknessCtrl.text);
    onBasinBaseThicknessChange(basinBaseThicknessCtrl.text);
    onInnerDiameterChange(baseInnerWidthCtrl.text);
    onBasinWallThicknessChange(basinWallThicknessCtrl.text);
    onInletSeaLevelChange(inletSeaLevelCtrl.text);
    onSurfaceSeaLevelChange(finishedSurfaceSeaLevelCtrl.text);
    onBasinOutletSeaLevelChange(basinOutSeaLevelCtrl.text);
    onPipeEndSeaLevelChange(outletSeaLevelCtrl.text);
    onValveboxInnerWidthChange(valveboxInnerWidthCtrl.text);
    onValveBoxSeaLevelChange(valveBoxBaseSeaLevelCtrl.text);
    onLowLevelChange(lowLevelCtrl.text);


    AppController.structInfo.recalculateData();
    AppController.sewageCalc.getEquivalentLength();
    AppController.sewageCalc.getTotalLength();
    AppController.sewageES.reCalculate();

    fittingsToLengthCtrl.text = nf.format(AppController.sewageCalc.equivalentPipeLength);
    totalLengthCtrl.text = nf.format(AppController.sewageCalc.totalLength);
    usableVolumeCtrl.text = nf.format(AppController.structInfo.useableVolume);
    usableVolumeHeightCtrl.text = nf.format(AppController.structInfo.useableVolumeH);
    inletToSurfaceHeightCtrl.text = nf.format(AppController.structInfo.inletToSurface);
    basinDepthCtrl.text = nf.format(AppController.structInfo.basinDepth);
    totalStructuralDepthCtrl.text = nf.format(AppController.structInfo.structureHeight);
    staticHeadCtrl.text = nf.format(AppController.structInfo.staticHead);
    outPipeToFinishedSurfaceCtrl.text = nf.format(AppController.structInfo.pipeOutToSurfaceHeight);
    valveBoxDepthCtrl.text = nf.format(AppController.structInfo.valveBoxH);
    pipeOutVelocityCtrl.text = nf.format(AppController.sewageES.pipeOutVelocity);
    pumpRecyclingCtrl.text = nf.format(AppController.sewageES.calculatedPumpStart);
    pumpRateCtrl.text = nf.format(AppController.sewageES.pumpRate);
    waterLevelToInletHeightCtrl.text = nf.format(AppController.structInfo.alarmToInletHeight + AppController.structInfo.flexibleHeight);
  }

  //This is for Debugging
  void preData(){
    lowLevelCtrl.text ="12.26";
    inflowCtrl.text = "200";
    pipeLengthController.text = "950";
    pipeDiameterController.text = "6";
    elbow45Controller.text = "4";
    elbow90Controller.text = "6";
    gateValveController.text = "1";
    checkValveController.text = "1";
    surfaceThicknessCtrl.text = "10";
    basinBaseThicknessCtrl.text = "24";
    baseInnerWidthCtrl.text = "6";
    basinWallThicknessCtrl.text = "1";
    inletSeaLevelCtrl.text = "1184.3";
    finishedSurfaceSeaLevelCtrl.text = "1198.0";
    outletSeaLevelCtrl.text = "1203"; 
    basinOutSeaLevelCtrl.text = "1193.1";
    valveboxInnerWidthCtrl.text = "1";
    valveBoxBaseSeaLevelCtrl.text = "1191.9";
  }


}