import 'dart:math' as math;

import 'package:my_app/calc/primitive_element.dart';
import 'package:my_app/calc/unit_convert.dart';


class StructuralInfo{
  List<String> baseShapeList = ["square", "circle"];
  List<String> valveBoxList = ["square"];

  final Double1 _inflow = Double1(); //GPM
  final Double1 _surfaceThickness = Double1(); //inches
  final Double1 _baseThickness = Double1(); //inches
  final Double1 _baseInnerDiameterW = Double1(); //feet
  final Double1 _floorArea = Double1();
  final Double1 _baseWallThickness = Double1();

  final Double1 _lowLevel = Double1();  //inches
  final Double1 _lagPumpFloatHeight = Double1();  //inches
  final Double1 _alarmToInletHeight = Double1.setVal(2); //inches
  final Double1 _valveBoxW = Double1.setVal(60); //feet
  final Double1 _valveBoxH = Double1(); //feet

  final Double1 _inletSeaLevel = Double1();  //feet
  final Double1 _surfaceSeaLevel = Double1(); //feet
  final Double1 _pipeOutSeaLevel = Double1(); //feet
  final Double1 _valBoxSeaLevel = Double1(); //feet
  final Double1 _baseSeaLevel = Double1(); // feet
  final Double1 _pipeOutBasinSeaLevel = Double1();
  final Double1 _pipeOutToSurfaceHeight = Double1();

  final Double1 _useableVolumeH = Double1();  //feet
  final Double1 _useableVolume = Double1(); //GALONS
  final Double1 _basinDepth = Double1(); 
  final Double1 _structureHeight = Double1();
  final Double1 _inletToSurface = Double1();
  final Double1 _staticHead = Double1();

  String baseShape = "square";
  String valveBoxShape = "square";
  double flexibleHeight = 0; //inches

  StringBuffer errorMessage = StringBuffer();

  //GETTERS
  double get inflow{return _inflow.get();}
  double get surfaceThickness{return _surfaceThickness.get();}
  double get baseThickness{return _baseThickness.get();}
  double get baseInnerDiameterW {return _baseInnerDiameterW.get();} //feet
  double get floorArea{return _floorArea.get();}
  double get baseWallThickness {return _baseWallThickness.get();}
  double get lowLevel {return _lowLevel.get();}
  double get lagPumpFloatHeight {return _lagPumpFloatHeight.get();}
  double get alarmToInletHeight {return _alarmToInletHeight.get();}
  double get valveBoxW {return _valveBoxW.get();}
  double get valveBoxH {return _valveBoxH.get();}

  double get inletSeaLevel {return _inletSeaLevel.get();}
  double get surfaceSeaLevel {return _surfaceSeaLevel.get();}
  double get pipeOutSeaLevel {return _pipeOutSeaLevel.get();} //Used for static head
  double get valBoxSeaLevel {return _valBoxSeaLevel.get();} 
  double get baseSeaLevel {return _baseSeaLevel.get();}
  double get pipeOutBasinSeaLevel {return _pipeOutBasinSeaLevel.get();} // Sealevel where pipe geting out of basin
  double get pipeOutToSurfaceHeight {return _pipeOutToSurfaceHeight.get();}

  // All calculated values are in feet or square feet
  double get useableVolumeH {return _useableVolumeH.get();}
  double get useableVolume {return _useableVolume.get();}
  double get basinDepth {return _basinDepth.get();}
  double get structureHeight {return _structureHeight.get();}
  double get inletToSurface {return _inletToSurface.get();} 
  double get staticHead {return _staticHead.get();}

  //SETTERS
  set inflow(double value){_inflow.set(value);}
  set surfaceThickness(double value){_surfaceThickness.set(value);}
  set baseThickness(double value){_baseThickness.set(value);}
  set baseInnerDiameterW(double value) {_baseInnerDiameterW.set(value);}
  set floorArea(double value){_floorArea.set(value);}
  set lagPumpFloatHeight(double value) {_lagPumpFloatHeight.set(value);}
  set alarmToInletHeight(double value) {_alarmToInletHeight.set(value); flexibleHeight = 0;}
  set valveBoxW(double value) { _valveBoxW.set(value);}
  set valveBoxH(double value) {_valveBoxH.set(value);}
  set inletSeaLevel(double value) {_inletSeaLevel.set(value);}
  set surfaceSeaLevel(double value) {_surfaceSeaLevel.set(value);}
  set pipeOutSeaLevel(double value) {_pipeOutSeaLevel.set(value);}
  set pipeOutBasinSeaLevel (double value) {_pipeOutBasinSeaLevel.set(value);}
  set pipeOutToSurfaceHeight (double value){ _pipeOutToSurfaceHeight.set(value);}

  //SET CALCULATED VALUE

  set lowLevel(double value) {_lowLevel.set(value);}
  set useableVolumeH(double value) {_useableVolumeH.set(value);}
  set useableVolume(double value) {_useableVolume.set(value);}
  set basinDepth(double value) {_basinDepth.set(value);}
  set structureHeight(double value) {_structureHeight.set(value);}
  set inletToSurface(double value) {_inletToSurface.set(value);}
  set staticHead(double value) {_staticHead.set(value);}
  set valBoxSeaLevel(double value){_valBoxSeaLevel.set(value);}
  set baseWallThickness(double value) {_baseWallThickness.set(value);}
  set baseSeaLevel(double value){ _baseSeaLevel.set(value);}

  
  StructuralInfo(){
    baseShape = baseShapeList[0];
    valveBoxShape = valveBoxList[0];
    _alarmToInletHeight.set(2);
    _lagPumpFloatHeight.set(12);
  }

  void recalculateData(){
    _floorArea.set(_baseArea());
    _getUsableVolume();
    _getUseableLength();
    _getHeightFromInletToSurface();
    _getBasinDepth();
    _getBaseSeaLevel();
    _getBasinFloorSeaLevel();
    _getTotalStructureHeight();
    _getStaticHead();
    _getBoxSeaLevel();
    _getPipeOutOfBasinToCover();
    _getValBoxHeight();
  }

  //Calculation
  double _baseArea(){
    String areaErr = "Based Area failed";
    if(baseShape == baseShapeList[0]){
      if(_baseInnerDiameterW.isValid()){
        _floorArea.set(_baseInnerDiameterW.get()*_baseInnerDiameterW.get());
        return _baseInnerDiameterW.get()*_baseInnerDiameterW.get();
      }else{
        errorMessage.writeln("$areaErr, Doesn't have Width value");
        return 0;
      }
    }else if(baseShape == baseShapeList[1]){
      if(_baseInnerDiameterW.isValid()){
        _floorArea.set((_baseInnerDiameterW.get()/2)*(_baseInnerDiameterW.get()/2)*math.pi);
        return (_baseInnerDiameterW.get()/2)*(_baseInnerDiameterW.get()/2)*math.pi;
      }else{
        errorMessage.writeln("$areaErr, doesn't have Diameter value");
        return 0;
      }
    }else{
      errorMessage.writeln("$areaErr, doesn't have value");
      return 0;
    }
  }

  double _getUsableVolume(){ //GPM
    String usableVolumeErr = "Usable Volume Error";
    if(_inflow.isValid()){
      _useableVolume.set(_inflow.get()*4);
      return _useableVolume.get();
    }else{
      errorMessage.writeln("$usableVolumeErr, doesn't have inflow value");
      return 0;
    }
  }

  double _getUseableLength(){
    String err = "Get Useable Volume Length";

    if(_useableVolume.isValid()){
      if(_floorArea.isValid()){
        double valueCubicFeet = UnitConvert.galonToCubicFeet(_useableVolume.get());
        _useableVolumeH.set(valueCubicFeet/_floorArea.get());
        return _useableVolumeH.get();
      }else{
        errorMessage.writeln("$err, Can't Get Base Area");
        return 0;
      }
    }else{
        errorMessage.writeln("$err, Can't Get Useable Volume");
      return 0;
    }
  }

  double _getHeightFromInletToSurface(){ //feet
    String err = "Height from Inlet to Surface Error";
    if(_surfaceSeaLevel.isValid()){
      if(_inletSeaLevel.isValid()){
        double height = _surfaceSeaLevel.get() - _inletSeaLevel.get();
        _inletToSurface.set(height);
        if(!_inletToSurface.isValid()){
          errorMessage.writeln("$err, height is less than zero");
          return 0;
        }else{
          return _inletToSurface.get();
        }
      }else{
        errorMessage.writeln("$err, doesn't have inlet sea level.");
        return 0;
      }
    }else{
        errorMessage.writeln("$err, doesn't have surface sea level.");
        return 0;
    }
  }

  double _getBasinDepth(){
    String err = "Get Basin Depth Error";

    if(_lowLevel.isValid()){
      if(_useableVolumeH.isValid()){
        if(_alarmToInletHeight.isValid()){
          if(_inletToSurface.isValid()){
            if(_surfaceThickness.isValid()){
              double temp = UnitConvert.inchToFeet(_lowLevel.get()) + 
                              _useableVolumeH.get() + // feet already
                              UnitConvert.inchToFeet(_alarmToInletHeight.get()) +
                              _inletToSurface.get() - // Minus Surface thickness
                              UnitConvert.inchToFeet(_surfaceThickness.get());

              double roudUp =  (temp*2).ceil().toDouble(); //Round up the half feet, so we time 2 to easier round.

              _basinDepth.set(roudUp/2);

              if(_basinDepth.isValid()){
                flexibleHeight = UnitConvert.feetToInch(roudUp/2 - temp);
                if(flexibleHeight < 0){
                  flexibleHeight = 0;
                }
                return _basinDepth.get();
              }else{
                errorMessage.writeln("$err, Basin Depth is 0 or negative.");
                return 0;
              }
            }else{
              errorMessage.writeln("$err, Doesn't have surface thickness.");
              return 0;
            }
          }else{
            errorMessage.writeln("$err, Doesn't have height of inlet to Surface.");
            return 0;
          }
        }else{
          errorMessage.writeln("$err, Doesn't have height from alarm float to inlet.");
          return 0;
        }
      }else{
        errorMessage.writeln("$err, Doesn't have usable volume height.");
        return 0;
      }
    }else{
      errorMessage.writeln("$err, Doesn't have minimum water height.");
      return 0;
    }
  }

  double _getBasinFloorSeaLevel(){
    String err = "Get Basin Floor Level Error";

    if(_basinDepth.isValid()){
      if(_surfaceThickness.isValid()){
        if(_surfaceSeaLevel.isValid()){
          _baseSeaLevel.set(
            _surfaceSeaLevel.get() -
            _basinDepth.get() -
            UnitConvert.inchToFeet(_surfaceThickness.get())
          );
          if(_baseSeaLevel.isValid()){
            return _baseSeaLevel.get();
          }else{
            errorMessage.writeln("$err, Basin Floor Sea Level Not Valid");
            return 0;
          }
        }else{
          errorMessage.writeln("$err, Surface Sea Level Not Valid");
          return 0;
        }
      }else{
        errorMessage.writeln("$err, Surface Thickness Not Valid");
        return 0;
      }
    }else{
      errorMessage.writeln("$err, Basin Depth Not Valid");
      return 0;
    }
  }
  
  double _getTotalStructureHeight(){
    String totalHeightErr = "Total Height of Structure Error";

    if(_surfaceThickness.isValid()){
      if(_baseThickness.isValid()){
        if(_basinDepth.isValid()){
          _structureHeight.set(_basinDepth.get() + 
                              UnitConvert.inchToFeet(_baseThickness.get()) +
                              UnitConvert.inchToFeet(_surfaceThickness.get())
          );
          if(!_structureHeight.isValid()){
            errorMessage.writeln("$totalHeightErr, Total height is 0 or negative.");
            return 0;
          }else{
            return _structureHeight.get();
          }
        }else{
          errorMessage.writeln("$totalHeightErr, Doesn't have Basin Depth.");
          return 0;
        }
      }else{
        errorMessage.writeln("$totalHeightErr, Doesn't have Base Thickness.");
        return 0;
      }
    }else{
      errorMessage.writeln("$totalHeightErr, Doesn't have Surface Thickness.");
      return 0;      
    }
  }

  double _getBaseSeaLevel(){
    String err = "Get Base Sea Level Error";
    if(_basinDepth.isValid()){
      if(_surfaceThickness.isValid()){
        if(_surfaceSeaLevel.isValid()){
          _baseSeaLevel.set(
            _surfaceSeaLevel.get() -
            (UnitConvert.inchToFeet(_surfaceThickness.get())) -
            _basinDepth.get()
          );

          if(_baseSeaLevel.isValid()){
            return _baseSeaLevel.get();
          }else{
            errorMessage.writeln("$err, Base Sea Level is 0 or Negative");
            return 0;
          }
        }else{
          errorMessage.writeln("$err, SurfaceSeaLevel is not valid");
          return 0;
        }
      }else{
          errorMessage.writeln("$err, Surface Thickness is not valid");
          return 0;
      }
    }else{
      errorMessage.writeln("$err, Basin Depth is not valid");
      return 0;
    }
  }


  double _getStaticHead(){ //Feet
    String staticHeadError = "Get Static Head Error";

    if(_baseSeaLevel.isValid()){
      if(_lowLevel.isValid()){
          if(_pipeOutSeaLevel.isValid()){
            _staticHead.set(
              _pipeOutSeaLevel.get() -
              _baseSeaLevel.get() -
              UnitConvert.inchToFeet(_lowLevel.get())
            );
            if(_staticHead.isValid()){
              return _staticHead.get();
            }else{
              errorMessage.writeln("$staticHeadError, Static Head height not valid");
              return 0;
            }
          }else{
            errorMessage.writeln("$staticHeadError, Can't get pipe out sea level");
            return 0;            
          }
      }else{
        errorMessage.writeln("$staticHeadError, Low Level not Valid");
        return 0;           
      }
    }else{
      errorMessage.writeln("$staticHeadError, Base Sealevel Not Valid.");
      return 0;        
    }
  }

  double _getBoxSeaLevel(){
    String err = "Box Sea Level Error";
    if(_surfaceSeaLevel.isValid()){
      if(_valveBoxH.isValid()){
        _valBoxSeaLevel.set(
          _surfaceSeaLevel.get() -
          (UnitConvert.inchToFeet(_valveBoxH.get()))
        );
        if(_surfaceSeaLevel.isValid()){
          return _surfaceSeaLevel.get();
        }else{
          errorMessage.writeln("$err, Surface Sea Level is not valid.");
          return 0;
        }
      }else{
        errorMessage.writeln("$err, can't find Valve Box Height.");
        return 0;        
      }
    }else{
      errorMessage.writeln("$err, can't find surface Sea Level.");
      return 0;        
    }
  }

  double _getValBoxHeight(){
    String err = "Get ValveBox height err";

    if(_valBoxSeaLevel.isValid()){
      if(_surfaceSeaLevel.isValid()){
        if(_surfaceThickness.isValid()){
          _valveBoxH.set(
            _surfaceSeaLevel.get() -
            _valBoxSeaLevel.get() -
            UnitConvert.inchToFeet(_surfaceThickness.get())
          );
          if(_valveBoxH.isValid()){
            return _valveBoxH.get();
          }else{
            errorMessage.writeln("$err, valve box height is zero or negative");
          }
        }else{
          errorMessage.writeln("$err, surface thickness is not valid");
        }
      }else{
        errorMessage.writeln("$err, surface sea level is not valid");
      }
    }else{
      errorMessage.writeln("$err, valve box sea level is not valid");
    }
    return 0;
  }


  double _getPipeOutOfBasinToCover(){
    String err = "_getPipeOutOfBasinToCover Err";

    if(_surfaceSeaLevel.isValid()){
      if(_pipeOutBasinSeaLevel.isValid()){
        if(_surfaceThickness.isValid()){
          _pipeOutToSurfaceHeight.set(
            _surfaceSeaLevel.get() -
            _pipeOutBasinSeaLevel.get() -
            UnitConvert.inchToFeet(_surfaceThickness.get())
          );
          if(_pipeOutToSurfaceHeight.isValid()){
            return _pipeOutToSurfaceHeight.get();
          }else{
            errorMessage.writeln("$err, _pipeOutToSurfaceHeight not valid");
            return 0;
          }
        }else{
          errorMessage.writeln("$err, surface thickness not valid");
          return 0;
        }
      }else{
        errorMessage.writeln("$err, pipeOutLetSeaLevel not valid");
        return 0;
      }
    }else{
      errorMessage.writeln("$err, surface Sea Level not valid");
      return 0;
    }
  }
  

  //MAP VALUES

  final String _inflowStr = "inflow";
  final String _surfaceThicknessStr = "surfaceThickness";
  final String _baseThicknessStr = "baseThickness";
  final String _baseInnerDiameterWStr = "baseInnerDiameterW";
  final String _floorAreaStr = "floorArea";
  final String _baseWallThicknessStr = "baseWallThickness";

  final String _lowLevelStr = "lowLevel";  //inches
  final String _lagPumpFloatHeightStr = "lagPumpFloatHeight";  //inches
  final String _alarmToInletHeightStr = "alarmToInletHeight"; //inches
  final String _valveBoxWStr = "valveBoxW"; //feet
  final String _valveBoxHStr = "valveBoxH"; //feet

  final String _inletSeaLevelStr = "inletSeaLevel";  //feet
  final String _surfaceSeaLevelStr = "surfaceSeaLevel"; //feet
  final String _pipeOutSeaLevelStr = "pipeOutSeaLevel"; //feet
  final String _valBoxSeaLevelStr = "valBoxSeaLevel"; //feet
  final String _baseSeaLevelStr = "baseSeaLevel"; // feet
  final String _pipeOutBasinSeaLevelStr = "pipeOutBasinSeaLevel";
  final String _pipeOutToSurfaceHeightStr = "pipeOutToSurfaceHeight";

  final String _useableVolumeHStr = "useableVolumeH";  //feet
  final String _useableVolumeStr = "useableVolume"; //GALONS
  final String _basinDepthStr = "basinDepth"; 
  final String _structureHeightStr = "structureHeight";
  final String _inletToSurfaceStr = "inletToSurface";
  final String _staticHeadStr = "staticHead";

  final String _baseShapeStr = "baseShape";
  final String _valveBoxShapeStr = "valveBoxShape";
  final String _flexibleHeightStr = "flexibleHeight"; //inches

  Map<String, dynamic> toMap(){
    return{
      _inflowStr: inflow,
      _surfaceThicknessStr: surfaceThickness,
      _baseThicknessStr: baseThickness,
      _baseInnerDiameterWStr: baseInnerDiameterW,
      _floorAreaStr: floorArea,
      _baseWallThicknessStr: baseWallThickness,
      _lowLevelStr: lowLevel,  //inches
      _lagPumpFloatHeightStr: lagPumpFloatHeight,  //inches
      _alarmToInletHeightStr: alarmToInletHeight, //inches
      _valveBoxWStr: valveBoxW, //feet
      _valveBoxHStr: valveBoxH, //feet
      _inletSeaLevelStr: inletSeaLevel,  //feet
      _surfaceSeaLevelStr: surfaceSeaLevel, //feet
      _pipeOutSeaLevelStr: pipeOutSeaLevel, //feet
      _valBoxSeaLevelStr: valBoxSeaLevel, //feet
      _baseSeaLevelStr: baseSeaLevel, // feet
      _pipeOutBasinSeaLevelStr: pipeOutBasinSeaLevel,
      _pipeOutToSurfaceHeightStr: pipeOutToSurfaceHeight,
      _useableVolumeHStr: useableVolumeH,  //feet
      _useableVolumeStr: useableVolume, //GALONS
      _basinDepthStr: basinDepth, 
      _structureHeightStr: structureHeight,
      _inletToSurfaceStr: inletToSurface,
      _staticHeadStr: staticHead,
      _baseShapeStr: baseShape,
      _valveBoxShapeStr: valveBoxShape,
      _flexibleHeightStr:  flexibleHeight,
    };
  }

  void fromMap(Map<String, dynamic> map){
      inflow = map[_inflowStr];
      surfaceThickness = map[_surfaceThicknessStr];
      baseThickness = map[_baseThicknessStr];
      baseInnerDiameterW = map[_baseInnerDiameterWStr];
      floorArea = map[_floorAreaStr];
      baseWallThickness = map[_baseWallThicknessStr];
      lowLevel = map[_lowLevelStr];  //inches
      lagPumpFloatHeight = map[_lagPumpFloatHeightStr];  //inches
      alarmToInletHeight = map[_alarmToInletHeightStr]; //inches
      valveBoxW = map[_valveBoxWStr]; //feet
      valveBoxH = map[_valveBoxHStr]; //feet
      inletSeaLevel = map[_inletSeaLevelStr];  //feet
      surfaceSeaLevel = map[_surfaceSeaLevelStr]; //feet
      pipeOutSeaLevel = map[_pipeOutSeaLevelStr]; //feet
      valBoxSeaLevel = map[_valBoxSeaLevelStr]; //feet
      baseSeaLevel = map[_baseSeaLevelStr]; // feet
      pipeOutBasinSeaLevel = map[_pipeOutBasinSeaLevelStr];
      pipeOutToSurfaceHeight = map[_pipeOutToSurfaceHeightStr];
      useableVolumeH = map[_useableVolumeHStr];  //feet
      useableVolume = map[_useableVolumeStr]; //GALONS
      basinDepth = map[_basinDepthStr]; 
      baseShape = map[_baseShapeStr];
      structureHeight = map[_structureHeightStr];
      inletToSurface = map[_inletToSurfaceStr];
      staticHead = map[_staticHeadStr];
      flexibleHeight = map[_flexibleHeightStr];
  }
}