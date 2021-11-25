import 'package:my_app/calc/app_controller.dart';

class PumpData{
  List<Pump> pumpList = [];

  PumpData(){
    _initModel();

  }

  void _initModel(){
    Pump barnes2SEL = Pump.newPump("Barnes", "2SE-L", 19.02);
    barnes2SEL.subModels = [
    PumpElectricDetails("SE51", "0.5" ,"120", "1", "11.6"),
    PumpElectricDetails("SE51A", "0.5" ,"120", "1", "11.6"),
    PumpElectricDetails("SE51AU", "0.5" ,"120", "1", "11.6"),
    PumpElectricDetails("SE52", "0.5" ,"240", "1", "5.9"),
    PumpElectricDetails("SE52AU", "0.5" ,"240", "1", "5.9"),
    PumpElectricDetails("SE594L", "0.5" ,"200-240", "3", "3.2/3.0"),
    PumpElectricDetails("SE544L", "0.5" ,"480", "3", "1.5"),
    PumpElectricDetails("SE554L", "0.5" ,"600", "3", "1.0"),
    PumpElectricDetails("SE774L", "0.75" ,"200-240", "1", "7.4/7.0"),
    PumpElectricDetails("SE794L", "0.75" ,"200-240", "3", "4.8/4.5"),
    PumpElectricDetails("SE744L", "0.75" ,"480", "3", "2.2"),
    PumpElectricDetails("SE754L", "0.75" ,"600", "3", "1.5"),
    PumpElectricDetails("SE1074L", "1.0" ,"200-240", "1", "8.8/8.3"),
    PumpElectricDetails("SE1094L", "1.0" ,"200-240", "3", "5.1/4.9"),
    PumpElectricDetails("SE1044L", "1.0" ,"480", "3", "2.4"),
    PumpElectricDetails("SE1054L", "1.0" ,"600", "3", "1.9"),
  ];

    //PUMP LIST FOR BARNES 2SE-L
    Map<double,double> l1 = {
      0 :	36,
      25:	33,
      50:	29.7,
      75:	27,
      100:	24.3,
      125:	21,
      150:	17.4,
      175:	13.4,
      200:  9.3,
      225: 5,
    };
    Impeller i1 = Impeller.newImpeller(6, l1);

    Map<double,double> l2 = {
      0:	30,
      25:	27,
      50:	24.1,
      75:	21.2,
      100:	18.3,
      125:	14.7,
      150:	11,
      175:	6.5,
    };
    Impeller i2 = Impeller.newImpeller(5.62, l2);

    Map<double,double> l3 = {
      0:	25.3,
      25:	22.3,
      50:	20,
      75:	17.5,
      100:	14.8,
      125:	11.8,
      150:	8.7,
      175:	6 
    };
    Impeller i3 = Impeller.newImpeller(5.25, l3); 

    Map<double,double> l4 = {
      0:	23,
      25:	20.4,
      50:	18,
      75:	15.3,
      100:	12.9,
      125:	10,
      150:	6.7,
    };
    Impeller i4 = Impeller.newImpeller(5, l4);

    Map<double,double> l5 = {
      0:	18.5,
      25:	16.2,
      50:	14,
      75:	11.8,
      100:	9.3,
      125:	6.7,
      150:	4,
    };
    Impeller i5 = Impeller.newImpeller(4.5, l5); 

    Map<double,double> l6 = {
      0:	15,
      25:	13,
      50:	11,
      75:	8.8,
      100:	6.5,
      125:	4,
    };
    Impeller i6 = Impeller.newImpeller(4, l6);

    barnes2SEL.impellerList.addAll([i1, i2, i3, i4, i5, i6]);

    Pump barnes3SEL = Pump.newPump("Barnes", "3SE-L", 21.49);
    barnes3SEL.subModels =   [
    PumpElectricDetails("3SE1524L", "1.5", "230", "1" ,"16.0"),
    PumpElectricDetails("3SE1594L", "1.5", "200-230", "3" , "13.3/11.6"),
    PumpElectricDetails("3SE1544L", "1.5", "460", "3", "5.8"),
    PumpElectricDetails("3SE1554L", "1.5", "575", "3", "4.6"),
    PumpElectricDetails("3SE2024L", "2.0", "230", "1", "19.0"),
    PumpElectricDetails("3SE2094L", "2.0", "200-230", "3", "15.2/13.2"),
    PumpElectricDetails("3SE2044L", "2.0", "460", "3", "6.6"),
    PumpElectricDetails("3SE2054L", "2.0", "575", "3", "5.2"),

    PumpElectricDetails("3SEH1524L", "1.5", "30", "1", "16.0"), 
    PumpElectricDetails("3SEH1594L", "1.5", "200-230", "3", "13.3/11.6"), 
    PumpElectricDetails("3SEH1544L", "1.5", "60", "3", "5.8"), 
    PumpElectricDetails("3SEH1554L", "1.5", "75", "3", "4.6"),
    PumpElectricDetails("3SEH2024L", "2.0", "30", "1", "19.0"),
    PumpElectricDetails("3SEH2094L", "2.0", "200-230", "3", "15.2/13.2"),
    PumpElectricDetails("3SEH2044L", "2.0", "60", "3", "6.6"), 
    PumpElectricDetails("3SEH2054L", "2.0", "75", "3", "5.2"), 
    ];

    Map<double,double> l7 = {
      0:	66,
      50:	60,
      100:	57,
      150:	52,
      200:	46.5,
      250:	41,
      300:	35,
      350:	26,
    };
    Impeller i7 = Impeller.newImpeller(7.5, l7);

    Map<double,double> l8 = {
      0:	60.5,
      50:	57,
      100:	52,
      150:	47.5,
      200:	43,
      250:	37,
      300:	30.5,
      350:	21.5, 
    };
    Impeller i8 = Impeller.newImpeller(7.25, l8);

    Map<double,double> l9 = {
      0:	56,
      50:	52,
      100:	48,
      150:	44,
      200:	39,
      250:	34,
      300:	27,
      350:	19.3,
    };
    Impeller i9 = Impeller.newImpeller(7, l9);

    Map<double,double> l10 = {
      0:	48,
      50:	44.3,
      100:	40,
      150:	36,
      200:	31.5,
      250:	26,
      300:	19.7,
      350:	13,
    };
    Impeller i10 = Impeller.newImpeller(6.5, l10);    

    Map<double,double> l11 = {
      0:	41,
      50:	37,
      100:	34,
      150:	30,
      200:	25.7,
      250:	20,
      300:	14,
      350:	9, 
    };
    Impeller i11 = Impeller.newImpeller(6, l11);

    Map<double,double> l12 = {
      0:	36,
      50:	33,
      100:	29,
      150:	25,
      200:	20,
      250:	15,
      300:	9,
    };
    Impeller i12 = Impeller.newImpeller(5.62, l12);

    barnes3SEL.impellerList.addAll([i7, i8, i9, i10, i11, i12]);

    Pump barnesSEV511521 = Pump.newPump("Barnes", "SEV-511/521", 16.76);
    barnesSEV511521.subModels =   [
      PumpElectricDetails("SE511", "0.5" ,"115", "1", "12.0" ),
      PumpElectricDetails("SE511A", "0.5" ,"115", "1", "12.0" ),
      PumpElectricDetails("SE511AU", "0.5" ,"115", "1", "12.0" ),
      PumpElectricDetails("SE511VF", "0.5" ,"115", "1", "12.0" ),
      PumpElectricDetails("SE521", "0.5" ,"230", "1", "6.2" ),
      PumpElectricDetails("SE521AU", "0.5" ,"230", "1", "6.2" ),
      PumpElectricDetails("SEV511", "0.5" ,"115", "1", "12.0" ),
      PumpElectricDetails("SEV511A", "0.5" ,"115", "1", "12.0" ),
      PumpElectricDetails("SEV511AU", "0.5" ,"115", "1", "12.0" ),
      PumpElectricDetails("SEV511VF", "0.5" ,"115", "1", "12.0" ),
      PumpElectricDetails("SEV521", "0.5" ,"230", "1", "6.2" ),
      PumpElectricDetails("SEV521AU", "0.5" ,"230", "1", "6.2" ),
    ];

    Map<double,double> l13 = {
      0:	25,
      12.5:	23.5,
      25:	22.4,
      37.5:	21,
      50:	19.5,
      62.5:	17.8,
      75: 16,
      87.5:	14.2,
      100: 12,
      112.5: 10,
      125: 7.5,
      137.5: 5,
      150: 2.5,     
    };
    Impeller i13 = Impeller.newImpeller(5.62, l13);

    Map<double,double> l14 = {
      0:	21.5,
      12.5:	19.5,
      25:	17.7,
      37.5:	16.5,
      50:	15,
      62.5:	13.5,
      75:	11.5,
      87.5:	9.5,
      100:	7.4,
      112.5: 	5,
      125: 2.5,    
    };
    Impeller i14 = Impeller.newImpeller(5.75, l14);

    barnesSEV511521.impellerList.addAll([i13, i14]);

    Pump barnesSP33 = Pump.newPump("Barnes", "SP33", 11.76);
    barnesSP33.subModels =  [
      PumpElectricDetails("SP33", "1/3", "120", "1", "5.8"),
      PumpElectricDetails("SP33X", "1/3", "120", "1", "5.8"),
      PumpElectricDetails("SP33A", "1/3", "120", "1", "5.8"),
      PumpElectricDetails("SP33AX", "1/3", "120", "1", "5.8"),
      PumpElectricDetails("SP33VF", "1/3", "120", "1", "5.8"),
      PumpElectricDetails("SP33VFX", "1/3", "120", "1", "5.8"),
      PumpElectricDetails("SP33D", "1/3", "120", "1", "5.8"),
    ];


    Map<double,double> l15 = {
      0:	30,
      5:	28.5,
      10:	26,
      15:	24,
      20:	22.3,
      25:	19.5,
      30:	17,
      35:	14,
      40:	11.5,
      45:	8,
      50:	5,
    };
    Impeller i15 = Impeller.newImpeller(-1, l15);

    barnesSP33.impellerList.add(i15);

    Pump barnesSP50 = Pump.newPump("Barnes", "SP50", 11.76);
    barnesSP50.subModels =  [
      PumpElectricDetails("SP50X" ,"1/2" ,"120" ,"1" ,"6.8"),
      PumpElectricDetails("SP50AX" ,"1/2" ,"120" ,"1" ,"6.8"),
      PumpElectricDetails("SP50VFX" ,"1/2" ,"120" ,"1" ,"6.8"),
    ];

    Map<double,double> l16 = {
      0	:  31,
      5	:  27,
      10:	26,
      15:	25,
      20:	24,
      25:	21.5,
      30:	20,
      35:	18,
      40:	17,
      45:	15,
      50:	13,
      55:	11,
      60:	9
    };
    Impeller i16 = Impeller.newImpeller(-1, l16);
    barnesSP50.impellerList.add(i16);

    Pump barnesSP75X= Pump.newPump("Barnes", "SP75", 12.26);
    barnesSP75X.subModels =  [
      PumpElectricDetails("SP75X", "3/4", "120", "1", "9.8"),
      PumpElectricDetails("SP75AX", "3/4", "120", "1", "9.8"),
      PumpElectricDetails("SP75VFX", "3/4", "120", "1", "9.8"),
    ];
    
    Map<double,double> l17 = {
      0:	32.5,
      5:	31.5,
      10:	31,
      15:	30.5,
      20:	30,
      25:	28.2,
      30:	27.5,
      35:	26,
      40:	24.5,
      45:	22.5,
      50:	20.5,
      55:	18,
      60:	16,
      65:	13.5,
      70:	11,
      75:	8,
      80:	5,
    };
    Impeller i17 = Impeller.newImpeller(-1, l17);
    barnesSP75X.impellerList.add(i17);


    pumpList.addAll([barnes2SEL, barnes3SEL, barnesSP75X, barnesSP50, barnesSP33, barnesSEV511521]);
  }
}

class Pump{
  String brand;
  String model;
  double lowlevel;
  String type = "Solids Handling";

  List<PumpElectricDetails> subModels = [];

  List<Impeller> impellerList = [];

  Pump.newPump(this.brand, this.model, this.lowlevel);

  final _brandStr = "brand";
  final _modelStr = "model";
  final _lowLevelStr = "lowLevel";
  final _typeStr = "type";



  Map<String, dynamic> toMap(){
    return {
      _brandStr : brand,
      _modelStr : model,
      _lowLevelStr : lowlevel,
      _typeStr : type
    };
  }

  Pump? fromMap(Map<String, dynamic> map){
    brand = map[_brandStr];
    model = map[_modelStr];
    lowlevel = map[_lowLevelStr];
    type = map[_typeStr];

    subModels.clear();
    impellerList.clear();

    for(Pump pump in AppController.pumpData.pumpList){
      if(pump.brand == brand && model == pump.model){
        return pump;
      }
    }
    return null;
  }
}


class PumpElectricDetails{
  String model = "";
  String hp = "";
  String voltage = "";
  String phase = "";
  String amps = "";

  PumpElectricDetails(this.model, this.hp, this.voltage, this.phase, this.amps);

  PumpElectricDetails.blank();

  final _modelStr = "model";
  final _hpStr = "hp";
  final _voltageStr = "voltage";
  final _phaseStr = "phase";
  final _ampsStr = "amps";

  Map<String, dynamic> toMap(){
    return {
      _modelStr : model,
      _hpStr : hp,
      _voltageStr : voltage,
      _phaseStr : phase,
      _ampsStr : amps,
    };
  }

  PumpElectricDetails? fromMap(Map<String, dynamic> map, Pump currentPump){
    model = map[_modelStr];
    hp = map[_hpStr];
    voltage = map[_voltageStr];
    phase = map[_phaseStr];
    amps = map[_ampsStr];

    for (var item in currentPump.subModels) {
      if(model == item.model){
        return item;
      }
    }

    return null;
  }

  void copy(PumpElectricDetails eDetails){
      model = eDetails.model;
      hp = eDetails.hp;
      voltage = eDetails.voltage;
      phase = eDetails.phase;
      amps = eDetails.amps; // Continue Here
  }
}

class Impeller{
  double impellerDia = 0;
  Map<double,double> feetGal = {};

  final String _impellerDiaStr = "impellerDia";
  final String _feetGalStr = "feetGal";

  Impeller();

  Impeller.newImpeller(double dia, this.feetGal){
    impellerDia = dia;
  }

  void copy(Impeller imp){
    impellerDia = imp.impellerDia;
    feetGal.addAll(imp.feetGal);
  }

  Map<String, dynamic> toMap(){
    return {
      _impellerDiaStr : impellerDia,
      //_feetGalStr : feetGal
    };
  }

  Impeller? fromMap(Map<String, dynamic> map, Pump pump){
    impellerDia = map[_impellerDiaStr];
    for (var element in pump.impellerList) {
      if(impellerDia == element.impellerDia){
        return element;
      }
    }
    return null;
  }
}