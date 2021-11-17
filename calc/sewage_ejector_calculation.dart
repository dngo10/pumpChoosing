
import 'package:my_app/calc/hazen_william.dart';
import 'package:my_app/calc/unit_convert.dart';

class SewageEjectorCalculation{
  String material = HazenWilliam.hw.keys.first;
  double C = HazenWilliam.hw.values.first;
  double diameter = 0;
  double inletGpm = 0;
  double staticHead = 0;
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

}