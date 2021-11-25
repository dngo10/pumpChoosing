import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/calc/class_input.dart';
import 'package:my_app/calc/pump_data.dart';
import 'package:my_app/calc/sewage_ejector_calculation.dart';
import 'package:my_app/calc/sewage_ejector_schedule.dart';
import 'package:my_app/calc/structural_info.dart';
import 'package:uuid/uuid.dart';

class AppController{
  static PumpData pumpData = PumpData();
  static StructuralInfo structInfo = StructuralInfo();
  static SewageEjectorSechedule sewageES = SewageEjectorSechedule();
  static SewageEjectorCalculation sewageCalc = SewageEjectorCalculation();
  static InputInfo inputInfo = InputInfo();

  static String url = "https://service9.de/api/data";
  static Uri uri =  Uri.parse(url);
  static const _data = "Data";
  static const _uuid = "Uuid";
  static bool isEditing = false;
  static String uuid = "";
  static Key key = GlobalKey();


  static const _structInfoStr = "structInfo";
  static const _sewageESStr = "sewageES";
  static const _sewageCalcStr = "sewageCalc";

  static Map<String,dynamic> toMap(){
    return {
      _structInfoStr : structInfo.toMap(),
      _sewageESStr : sewageES.toMap(),
      _sewageCalcStr : sewageCalc.toMap(),
    };
  }

  static void fromMap(Map<String, dynamic> map){
    Map<String, dynamic> structInfoMap = map[_structInfoStr] as Map<String, dynamic>;
    Map<String, dynamic> sewageESMap = map[_sewageESStr] as Map<String, dynamic>;
    Map<String, dynamic> sewageCalcMap = map[_sewageCalcStr] as Map<String, dynamic>;

    structInfo.fromMap(structInfoMap);
    sewageES.fromMap(sewageESMap);
    sewageCalc.fromMap(sewageCalcMap);
  }

  static String toJson(){
    if(!isEditing){
      uuid = const Uuid().v4();
    }

    Map<String, dynamic> mp = toMap();

    Map<String, dynamic> map = {
      _uuid: uuid,
      _data : json.encode(mp)
    };

    return  json.encode(map);
  }

  static void fromJson(String json){
    
    isEditing = true;

    Map<String,String> map = jsonDecode(json) as Map<String, String>;
    uuid = map[_uuid] as String;
    String mapString = map[_data] as String;
    Map<String, dynamic> dataMap = jsonDecode(mapString) as Map<String, dynamic>;
    fromMap(dataMap);
  }

  static submitData() async{
    String json = toJson();
    http.post(
      Uri.parse(url + "/edit"),
      body: json,
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    ).then((value){
      if(value.statusCode > 300){
        print("Failed -- Status Code: ${value.statusCode}");
      }else{
        Clipboard.setData(ClipboardData(text: json)).then((value){
          exit(0);
        });
      }
    });
  }

  static readData() async{
    RegExp rg = RegExp(r'^\b[0-9a-f]{8}\b-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-\b[0-9a-f]{12}\b$');
    ClipboardData? data = await Clipboard.getData('text/plain');
    String? temp = data!.text;

    if(rg.hasMatch(temp!.trim())){
      String uuid = temp.trim();
      http.Response response = await http.get(Uri.parse(url + "/$uuid"));
      
      if(response.statusCode < 300){
        await Clipboard.setData(const ClipboardData(text: ''));  
        fromJson(response.body);
        inputInfo.preReadJson();
      }
    }
  }

  static List<String> flushOrTank = ["tank", "flush"];

}