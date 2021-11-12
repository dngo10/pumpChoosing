class SewageEjectorSechedule{

  List<SewageType> sewageTypeList = [];

  SewageEjectorSechedule(){
    sewageTypeList = [
      SewageType("sewage", "SE", 2),
      SewageType("sump pump", "SP", 3),
      SewageType("grease sewage", "GSE", 4),
    ];

    sewageType = sewageTypeList[0];
  }
  SewageType sewageType = SewageType("", "", -1);
  String tagNum = "1";
  String location = "input location";
  String basinDimension = "input dimension";
  String manufacture = "XXXXX";
  String model = "XXXXX";
  String type = "SOLID HANDLING";
  String service = "Sewage";
  double gpm = 0;
  double headPressure = 0;
  String bHousePower = "XX";
  String volTage = "208V";
  String phase = "3";
  String amps = "XX";
  double cableLength = 0;
  double minPumpstart = 6; //in minutes;
  double calculatedPumpStart = 0;
  double pipeOutVelocity = 0;

  final _sewageTypeStr = "SewageType";
  final _tagNumStr = "TagNum";
  final _locationStr = "Location";
  final _basinDimensionStr = "BasinDimension";
  final _manufactureStr = "Manufacture";
  final _modelStr = "Model";
  final _typeStr = "Type";
  final _serviceStr = "Service";
  final _gpmStr = "Gpm";
  final _headPressureStr = "HeadPressure";
  final _bHousePowerStr = "B_HousePower";
  final _volTageStr = "Voltage";
  final _phaseStr = "Phase";
  final _ampsStr = "Amps";
  final _cableLengthStr = "CableLength";
  final _minPumpstartStr = "MinPumpstart";
  final _calculatedPumpStartStr = "CalculatedPumpStart";
  final _pipeOutVelocityStr = "pipeOutVelocity";


  Map<String, dynamic> toMap(){
    return <String,dynamic>{
      _sewageTypeStr : sewageType.toMap(),
      _tagNumStr : tagNum,
      _locationStr: location,
      _basinDimensionStr: basinDimension,
      _manufactureStr: manufacture,
      _modelStr: model,
      _typeStr: type,
      _serviceStr: service,
      _gpmStr: gpm,
      _headPressureStr: headPressure,
      _bHousePowerStr: bHousePower,
      _volTageStr: volTage,
      _phaseStr: phase,
      _ampsStr: amps,
      _cableLengthStr: cableLength,   
      _minPumpstartStr: minPumpstart,
      _calculatedPumpStartStr : calculatedPumpStart,
      _pipeOutVelocityStr : pipeOutVelocity,
    };
  }

  void fromMap(Map<String, dynamic> map){
    sewageType.fromMap(map[_sewageTypeStr] as Map<String, dynamic>);
    tagNum = map[_tagNumStr];
    location = map[_locationStr];
    basinDimension = map[_basinDimensionStr];
    manufacture = map[_manufactureStr];
    model = map[_modelStr];
    type = map[_typeStr];
    service = map[_serviceStr];
    gpm = map[_gpmStr];
    headPressure = map[_headPressureStr];
    bHousePower = map[_bHousePowerStr];
    volTage = map[_volTageStr];
    phase = map[_phaseStr];
    amps = map[_ampsStr];
    cableLength = map[_cableLengthStr];
    minPumpstart = map[_minPumpstartStr];
    calculatedPumpStart = map[calculatedPumpStart];
    pipeOutVelocity = map[_pipeOutVelocityStr];
  }
}

class SewageType{
  String name;
  String tag;
  double minVelocity;

  String nameStr = "name";
  String tagStr = "tag";
  String minVelocityStr = "minVelocity";  

  SewageType(this.name, this.tag, this.minVelocity);

  Map<String, dynamic> toMap(){
    return {
      nameStr : name,
      tagStr : tag,
      minVelocityStr : minVelocity
    };
  }

  void fromMap(Map<String, dynamic> map){
    name = map[nameStr];
    tag = map[tagStr];
    minVelocity = map[minVelocityStr];
  }
}