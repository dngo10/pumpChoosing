
import 'package:my_app/calc/hazen_william.dart';
import 'package:my_app/calc/unit_convert.dart';

class SewageEjectorCalculation{
  String material = HazenWilliam.hw.keys.first;
  double C = HazenWilliam.hw.values.first;
  double diameter = 6;
  double pipeLength = 0;
  double numOf45Elbow = 0;
  double numOf90Elbow = 0;
  double numofGateValve = 0;
  double numofCheckValve = 0;

  double equivalentPipeLength = 0;
  double totalLength = 0;

  double getEquivalentLength(){
    equivalentPipeLength = numOf45Elbow*UnitConvert.elbow45[diameter]! +
           numOf90Elbow*UnitConvert.elbow90[diameter]! +
           numofCheckValve*UnitConvert.backWaterValve[diameter]! +
           numofGateValve*UnitConvert.gateValve[diameter]!;
    return equivalentPipeLength;
  }

  double getTotalLength(){
    totalLength = equivalentPipeLength + pipeLength;
    return totalLength;
  }

  final String _materialStr = "material";
  final String _CStr = "C";
  final String _diameterStr = "diameter";
  final String _pipeLengthStr = "pipeLength";
  final String _numOf45ElbowStr = "numOf45Elbow";
  final String _numOf90ElbowStr = "numOf90Elbow";
  final String _numofGateValveStr = "numofGateValve";
  final String _numofCheckValveStr = "numofCheckValve";
  final String _equivalentPipeLengthStr = "equivalentPipeLength";
  final String _totalLengthStr = "totalLength";

  Map<String, dynamic> toMap(){
    return {
      _materialStr : material,
      _CStr : C,
      _diameterStr : diameter,
      _pipeLengthStr : pipeLength,
      _numOf45ElbowStr : numOf45Elbow,
      _numOf90ElbowStr : numOf90Elbow,
      _numofGateValveStr : numofGateValve,
      _numofCheckValveStr : numofCheckValve,
      _equivalentPipeLengthStr: equivalentPipeLength,
      _totalLengthStr: totalLength,
    };
  }

  void fromMap(Map<String, dynamic> map){
      material = map[_materialStr];
      C = map[_CStr];
      diameter = map[_diameterStr];
      pipeLength = map[_pipeLengthStr];
      numOf45Elbow = map[_numOf45ElbowStr];
      numOf90Elbow = map[_numOf90ElbowStr];
      numofGateValve = map[_numofGateValveStr];
      numofCheckValve = map[_numofCheckValveStr];
      equivalentPipeLength = map[_equivalentPipeLengthStr];
      totalLength = map[_totalLengthStr];

      if(!HazenWilliam.hw.containsKey(material)){
        material = HazenWilliam.hw.keys.first;
        C = HazenWilliam.hw.values.first;
      }else{
        C = HazenWilliam.hw[material]!;
      }
  }

}