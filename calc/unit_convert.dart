class UnitConvert{
  static const double _doubleFt3Gallon = 7.4805194805195;
  static const double _ft2Inch2 = 144;
  static const double _ft3Inch3 = 1728;

  static double inchToFeet(double value){
    return value/12;
  }

  static double feetToInch(double value){
    return value*12;
  }

  static double cubicFeetToGalon(double value){
    return value*_doubleFt3Gallon;
  }

  static double galonToCubicFeet(double value){
    return value/_doubleFt3Gallon;
  }

  static double squareFootToSquareInch(double value){
    return value*_ft2Inch2;
  }

  static double squareInchToSquareFoot(double value){
    return value/_ft2Inch2;
  }

  static double cubicFootToCubicInch(double value){
    return value*_ft3Inch3;
  }

  static double cubicInchToCubicFoot(double value){
    return value/_ft3Inch3;
  }

  static Map<double, double> elbow90 = <double, double>{
    2 : 7,
    3 : 10,
    4 : 14,
    6 : 20,
    8 : 21,
    10 : 26,
    12 : 32,
    14 : 36,
    16 : 42,
  };

  static Map<double, double> elbow45 = <double,double>{
    2: 4,
    3: 6,
    4: 8,
    6: 12,
    8: 14,
    10: 17,
    12: 19,
    14: 21,
    16: 23,
  };

  static Map<double, double> gateValve = <double, double>{
    2: 1.3,
    3: 2,
    4: 2.7,
    6: 4,
    8: 4.5,
    10: 5.7,
    12: 6.7,
    14: 8,
    16: 9,
  };

  static Map<double,double> backWaterValve = <double,double>{
    2: 11,
    3: 16,
    4: 22,
    6: 31,
    8: 53,
    10: 67,
    12: 80,
    14: 93,
    16: 107,
  };

  
}