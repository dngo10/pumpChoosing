import 'package:my_app/calc/app_controller.dart';
import 'package:my_app/calc/charts/helper.dart';
import 'package:my_app/calc/charts/point.dart';
import 'package:my_app/calc/pump_data.dart';
import 'dart:math' as math;

import 'package:my_app/calc/unit_convert.dart';

class SewageEjectorSechedule{

  List<SewageType> sewageTypeList = [];

  SewageEjectorSechedule(){
    sewageTypeList = [
      SewageType("sewage", "SE", 2),
      SewageType("sump pump", "SP", 3),
      SewageType("grease sewage", "GSE", 4),
    ];

    sewageType = sewageTypeList[0];
    impeller = currentPumpSeries.impellerList.first;
  }

  SewageType sewageType = SewageType("", "", -1);
  String tagNum = "1";
  String location = "input location";
  String basinDimension = "input dimension";
  String manufacture = "Barnes"; // It's always Barnes
  String typePump = "Solids Handling";
  Pump  currentPumpSeries = AppController.pumpData.pumpList.first;
  PumpElectricDetails  currentPumpModel = AppController.pumpData.pumpList.first.subModels.first;
  double pumpRate = -1;
  double hn = -1;
  double cableLength = 0;
  double minPumpstart = 6; //in minutes;
  double calculatedPumpStart = 0;
  double pipeOutVelocity = 0;
  Impeller impeller = Impeller();

  Map<double, double> systemCurve = {};

  //This curve is for 1 2 4 5 min graph
  Map<double, double> pumpRateCurve = {};

  final _sewageTypeStr = "SewageType";
  final _tagNumStr = "TagNum";
  final _locationStr = "Location";
  final _basinDimensionStr = "BasinDimension";
  final _manufactureStr = "Manufacture";
  final _currentPumpSeriesStr = "currentPumpSeries";
  final _currentPumpModelStr = "currentPumpModel";
  final _pumpRateStr = "pumpRate";
  final _hnStr = "hnStr";
  final _typePumpStr = "typePump";
  final _cableLengthStr = "CableLength";
  final _minPumpstartStr = "MinPumpstart";
  final _calculatedPumpStartStr = "CalculatedPumpStart";
  final _pipeOutVelocityStr = "pipeOutVelocity";
  final _currentImpellerDiaStr = "currentImpellerDia";



  Map<String, dynamic> toMap(){
    return <String,dynamic>{
      _sewageTypeStr : sewageType.toMap(),
      _tagNumStr : tagNum,
      _locationStr: location,
      _basinDimensionStr: basinDimension,
      _manufactureStr: manufacture,
      _currentPumpSeriesStr: currentPumpSeries.toMap(),
      _currentPumpModelStr : currentPumpModel.toMap(),
      _pumpRateStr : pumpRate,
      _hnStr : hn,
      _typePumpStr : typePump,
      _cableLengthStr: cableLength,   
      _minPumpstartStr: minPumpstart,
      _calculatedPumpStartStr : calculatedPumpStart,
      _pipeOutVelocityStr : pipeOutVelocity,
      _currentImpellerDiaStr : impeller.toMap(),
    };
  }

  void fromMap(Map<String, dynamic> map){
    sewageType = sewageType.fromMap(map[_sewageTypeStr] as Map<String, dynamic>)!;
    tagNum = map[_tagNumStr];
    location = map[_locationStr];
    basinDimension = map[_basinDimensionStr];
    manufacture = map[_manufactureStr];
    typePump = map[_typePumpStr];
    cableLength = map[_cableLengthStr];
    minPumpstart = map[_minPumpstartStr];
    calculatedPumpStart = map[calculatedPumpStart];
    pipeOutVelocity = map[_pipeOutVelocityStr];
    pumpRate = map[_pumpRateStr];
    hn = map[_hnStr];

    Map<String, dynamic>  _currentPumpSeries = map[_currentPumpSeriesStr];
    currentPumpSeries = currentPumpSeries.fromMap(_currentPumpSeries)!;

    impeller = impeller.fromMap(map[_currentImpellerDiaStr], currentPumpSeries)!;

    Map<String, dynamic> _currentPumpModel = map[_currentPumpModelStr];
    currentPumpModel = currentPumpModel.fromMap(_currentPumpModel, currentPumpSeries)!;
  }

  void reCalculate(){
    getPumpRate();
    getPipeOutVelocity();
    getPumpRecyclingTime();
    getPumpRateCurve();
  }

  void getPumpRateCurve(){
    //For now we use minPumpstart for this equation.
    //It can be calculatedRecylcing time too, prepare to change.
    pumpRateCurve.clear();
    double sumDepth= 2;
    double maxY = 4*AppController.structInfo.inflow*minPumpstart/
        (5*AppController.structInfo.floorArea*7.48) +
        AppController.structInfo.inletToSurface -
        UnitConvert.inchToFeet(AppController.structInfo.surfaceThickness) +
        UnitConvert.inchToFeet(
          AppController.structInfo.alarmToInletHeight +
          AppController.structInfo.flexibleHeight
        );
    maxY = maxY.ceil().toDouble();
    
    for(double i = sumDepth; i <= maxY; i+=0.5){
      double useableVolumeHeight =
      i -
      UnitConvert.inchToFeet(
        AppController.structInfo.lowLevel +
        AppController.structInfo.alarmToInletHeight +
        AppController.structInfo.flexibleHeight) -
      AppController.structInfo.inletToSurface +
      UnitConvert.inchToFeet(AppController.structInfo.surfaceThickness);

      double usableVolume = AppController.structInfo.floorArea * useableVolumeHeight*7.48;

      double value = usableVolume/
      (minPumpstart - usableVolume/AppController.structInfo.inflow) + AppController.structInfo.inflow;

      if(value <0 || value > 10*AppController.structInfo.inflow){
        continue;
      }else{
        pumpRateCurve[value] = i;
      }
    }
  }

  void getPumpRecyclingTime(){
    if(AppController.structInfo.inflow != 0){
      calculatedPumpStart = AppController.structInfo.useableVolume/
                          (pumpRate - AppController.structInfo.inflow) + 
                          pumpRate/AppController.structInfo.inflow;
    }else{
      calculatedPumpStart = 0;
    }
  }

  void getPipeOutVelocity(){
    if(pumpRate != -1 && AppController.sewageCalc.diameter != 0){
      pipeOutVelocity = 
        (pumpRate/(7.48*60))/
        ((math.pi/4)*math.pow(AppController.sewageCalc.diameter/12, 2));
    }else{
      pipeOutVelocity = -1;
    }
  }

  void getPumpRate(){
    _getSystemCurveList();
    Point? temp = Helper.getInterSecionOf2Map(systemCurve, impeller.feetGal);
    if(temp != null){
      pumpRate = temp.x;
      hn = temp.y - AppController.structInfo.staticHead;
    }else{
      pumpRate = -1;
      hn = -1;
    }
  }

  void _getSystemCurveList(){
    systemCurve.clear();

    double highest = impeller.feetGal.keys.last;
    double lowest = impeller.feetGal.keys.first;
    if(lowest < 0) lowest = 0;

    var step = lowest;
    double endPoint = 0;

    while(highest > step){
      systemCurve[step] = _getHn(step);
      if(systemCurve[step] == -1){
        systemCurve.clear(); return;
      }
      endPoint = step + 2;
      if(endPoint >= highest){
        step = highest;
        systemCurve[step] = _getHn(step);
        if(systemCurve[step] == -1){
          systemCurve.clear(); return;
        }
        break;
      }else{
        step = endPoint;
      }
    }
  }

  double _getHn(double q){
    if(AppController.sewageCalc.diameter != 0 && AppController.sewageCalc.C != 0) {
      return
     (
      (10.51*math.pow(q, 1.85))/
      (math.pow(AppController.sewageCalc.C, 1.85)*math.pow(AppController.sewageCalc.diameter , 4.87))
      )*AppController.sewageCalc.totalLength +
      AppController.structInfo.staticHead;
    }else{
      return -1;
    }
  }


}

class SewageType{
  String name;
  String tag;
  double minVelocity;

  final String _nameStr = "name";
  final String _tagStr = "tag";
  final String _minVelocityStr = "minVelocity";  

  SewageType(this.name, this.tag, this.minVelocity);

  Map<String, dynamic> toMap(){
    return {
      _nameStr : name,
      _tagStr : tag,
      _minVelocityStr : minVelocity
    };
  }

  SewageType? fromMap(Map<String, dynamic> map){
    name = map[_nameStr];
    tag = map[_tagStr];
    for (var element in AppController.sewageES.sewageTypeList) {
      if(element.name == name && element.tag == tag){
        return element;
      }
    }
  }
}