import 'package:my_app/calc/app_controller.dart';
import 'package:my_app/calc/charts/point.dart';
import 'package:my_app/calc/pump_data.dart';

class SumpSizeChart{
  List<Point> sumPumpCors = [];
  List<Point> min1 = [];
  List<Point> min2 = [];
  List<Point> min3 = [];
  List<Point> min4 = [];
  List<Point> min5 = [];

  void populateSumpPumpCors(double dia){
    for(Impeller impeller in AppController.sewageES.currentPumpSeries.impellerList){
      if(impeller.impellerDia == -1){
        sumPumpCors.clear();
        impeller.feetGal.forEach((key, value) {
          Point xy = Point.setVal(key, value);
          sumPumpCors.add(xy);
        });
      }
    }
  }

  void sumpSizeChart(){
    if(AppController.structInfo.inflow > 0
       
      ){

    } 
  }
}