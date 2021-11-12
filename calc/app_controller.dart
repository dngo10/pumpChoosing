
import 'package:my_app/calc/class_input.dart';
import 'package:my_app/calc/pump_data.dart';
import 'package:my_app/calc/sewage_ejector_calculation.dart';
import 'package:my_app/calc/sewage_ejector_schedule.dart';
import 'package:my_app/calc/structural_info.dart';

class AppController{
  static PumpData pumpData = PumpData();
  static StructuralInfo structInfo = StructuralInfo();
  static SewageEjectorSechedule sewageES = SewageEjectorSechedule();
  static SewageEjectorCalculation sewageCalc = SewageEjectorCalculation();
  static InputInfo inputInfo = InputInfo();

  static List<String> flushOrTank = ["tank", "flush"];
}