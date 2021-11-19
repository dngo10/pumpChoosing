import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/calc/app_controller.dart';
import 'package:my_app/calc/pump_data.dart';
import 'package:my_app/calc/sewage_ejector_schedule.dart';
import 'package:my_app/gui/dfu_gpm/dfu_gpm.dart';
import 'package:my_app/gui/plumbing_info/general_input.dart';
import 'package:my_app/gui/plumbing_info/pipe_material.dart';

class ColumnPlumbing extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ColumnPlumbing();
  }
}

class _ColumnPlumbing extends State<ColumnPlumbing>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom:  100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText("Plumbing Info Input"),
              GeneralInput("gpm", "Inflow", AppController.inputInfo.inflowCtrl , "inflow", AppController.inputInfo.onInflowchange),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Pipe Material: ", style: TextStyle(fontStyle: FontStyle.italic),),
              ),
              PipeMaterial(),
              GeneralInput("ft", "Pipe Length",  AppController.inputInfo.pipeLengthController, "piple length of the plumbing system", AppController.inputInfo.onPipeLengthChange),
              GeneralInput("in", "Pipe Diameter", AppController.inputInfo.pipeDiameterController, "diameter of outlet pipe [2, 3, 4, 6, 8, 10, 12, 14, 16]", AppController.inputInfo.onPipeDiameterChange),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TitleText("Fittings Input"),
              ),
              GeneralInput("unit", "45", AppController.inputInfo.elbow45Controller, "amount of 45 elbow fitting", AppController.inputInfo.onElbow45Change),
              GeneralInput("unit", "90", AppController.inputInfo.elbow90Controller, "amount of 90 elbow fitting", AppController.inputInfo.onElbow90Change),
              GeneralInput("unit", "Gate Valve", AppController.inputInfo.gateValveController, "amount of gate valve", AppController.inputInfo.onGateValveChange),
              GeneralInput("unit", "Check Valve", AppController.inputInfo.checkValveController, "amount of check value", AppController.inputInfo.onCheckValveChange),
              DfuToGpm(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  child: const Text("Example (For Testing)"),
                  onPressed:() {
                    AppController.inputInfo.preData();
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              TitleText("Basin Input"),
              GeneralInput("in", "[I] cover's thickness", AppController.inputInfo.surfaceThicknessCtrl, "thickness of basin's cover", AppController.inputInfo.onSurfaceThicknessChange),
              GeneralInput("in", "[A] floor thickness", AppController.inputInfo.basinBaseThicknessCtrl, "thickness of basin's floor", AppController.inputInfo.onBasinBaseThicknessChange),
              GeneralInput("ft", "[U] inner diameter", AppController.inputInfo.baseInnerWidthCtrl, "inter basin's diameter or width", AppController.inputInfo.onInnerDiameterChange),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Shape of Basin Floor: ", style: TextStyle(fontStyle: FontStyle.italic),),
              ),
              DropdownButton(items: AppController.structInfo.baseShapeList.map<DropdownMenuItem<String>>((e){
                  return DropdownMenuItem(child: Text(e), value: e,);
                }).toList(),
                value : AppController.structInfo.baseShape,
                onChanged: (e){
                  AppController.inputInfo.onBasinShapeChange(e as String);
                },
              ),
              GeneralInput("ft", "[B] wall thickness", AppController.inputInfo.basinWallThicknessCtrl, "Basin Wall Thickness", AppController.inputInfo.onBasinWallThicknessChange),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: TitleText("Sea Level Input"),
              ),
              GeneralInput("ft", "[G] inlet sea level", AppController.inputInfo.inletSeaLevelCtrl, "Sea level of pipe getting into basin", AppController.inputInfo.onInletSeaLevelChange),
              GeneralInput("ft", "[J] surface sea level", AppController.inputInfo.finishedSurfaceSeaLevelCtrl, "Surface sea level", AppController.inputInfo.onSurfaceSeaLevelChange),
              GeneralInput("ft", "[L] pipe out of basin sea level", AppController.inputInfo.basinOutSeaLevelCtrl, "Sea level of pipe geting out of basin", AppController.inputInfo.onBasinOutletSeaLevelChange),
              GeneralInput("ft", "[Q] pipe outlet ended sea level", AppController.inputInfo.outletSeaLevelCtrl, "Sea level of the end if pipe outlet, we use this to calculate static head", AppController.inputInfo.onPipeEndSeaLevelChange),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: TitleText("Valve Box Input"),
              ),
              GeneralInput("ft", "[N] inner width", AppController.inputInfo.valveboxInnerWidthCtrl, "Inner width of valve box", AppController.inputInfo.onValveboxInnerWidthChange),
              GeneralInput("ft", "[P] floor sea level", AppController.inputInfo.valveBoxBaseSeaLevelCtrl, "Sea level at the bottom of valve box", AppController.inputInfo.onValveBoxSeaLevelChange),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText("Pump Input"),
              DropdownButton(items: 
                AppController.pumpData.pumpList.map<DropdownMenuItem<Pump>>((e){
                  return DropdownMenuItem(child: 
                    SizedBox(child: Text(e.model), width: 175),
                    value: e,
                  );
                }).toList(),
                value: AppController.sewageES.currentPumpSeries,
                onChanged: (pump){
                  AppController.inputInfo.onSeriesBoxChange(pump as Pump);
                },
              ),

              DropdownButton(items: 
                AppController.sewageES.currentPumpSeries.subModels.map<DropdownMenuItem<PumpElectricDetails>>((e){
                  return DropdownMenuItem(child: 
                    SizedBox(child: Text(e.model), width: 175),
                    value: e,
                  );
                }).toList(),
                value: AppController.sewageES.currentPumpModel,
                onChanged: (model){
                  AppController.inputInfo.onSubModelBoxChange(model as PumpElectricDetails);
                },
              ),

              GeneralInput("in", "[C] Low Level", AppController.inputInfo.lowLevelCtrl, "Low Water Level, equals to height of pump", AppController.inputInfo.onLowLevelChange),
              GeneralInput("hp", "Horse Power", AppController.inputInfo.horsePowerCtrl, "Pump's Horse Power", AppController.inputInfo.onHorsePowerChange),
              GeneralInput("V", "Voltage", AppController.inputInfo.voltageCtrl, "Pump's Voltage", AppController.inputInfo.onVoltageChange),
              GeneralInput("", "Phase", AppController.inputInfo.phaseCtrl, "Pump's Phase", AppController.inputInfo.onPhaseChange),
              GeneralInput("A", "AMPS F.L. ", AppController.inputInfo.ampsCtrl, "Pump's Amp", AppController.inputInfo.onAmpsChange),
              GeneralInput("ft", "Pump Cable Length", AppController.inputInfo.pumpCableLengthCtrl, "Cord Length from control panel to pump", AppController.inputInfo.onPumpCableLengthChange),
              GeneralInput("min", "Minimum Pump Recycles", AppController.inputInfo.minPumpStartCtrl, "Minimum time between pump starts", AppController.inputInfo.onMinPumpStartChange),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TitleText("Water Type"),
              ),

              DropdownButton(items: 
                AppController.sewageES.sewageTypeList.map<DropdownMenuItem<SewageType>>((e){
                  return DropdownMenuItem(child: 
                    SizedBox(child: Text(e.name), width: 175),
                    value: e,
                  );
                }).toList(),
                value: AppController.inputInfo.waterType,
                onChanged: (model){
                  AppController.inputInfo.onWaterTypeChange(model as SewageType);
                },
              ),

              GeneralInput("", "Num Tag ", AppController.inputInfo.tagNumCtrl, "Num Tag", AppController.inputInfo.onTagNumChange),

              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 10),
                child: SizedBox(
                  width: 180,
                  child: ButtonTheme(
                      child: ElevatedButton(
                              child: const Text("Calculate Other Values"),
                              onPressed: (){ AppController.inputInfo.onRecalculateButtonPress();},
                            )
                  ),
                ),
              )
            ],


          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText("Calculated Data"),
              GeneralInput("", "Hazem William Coefficient", AppController.inputInfo.hazenCoEfficientCtrl, "Hazem William Coefficient Value based on Material", AppController.inputInfo.onHazemWilliamCofficientChange),
              GeneralInput("ft", "fittings equiv to length", AppController.inputInfo.fittingsToLengthCtrl, "Convert all fittings to length", AppController.inputInfo.onFittingsEquivToLengthChange),
              GeneralInput("ft", "total pipe length", AppController.inputInfo.totalLengthCtrl, "Equals to pipe length + fittings equivalent length", AppController.inputInfo.onTotalPipeLengthChange),
              
              GeneralInput("sqft", "[T] Basin Area", AppController.inputInfo.basinFloorAreaCtrl, "Basin Area", AppController.inputInfo.onBasinFloorAreaChange),
              
              GeneralInput("gal", "[D] Useable Volume", AppController.inputInfo.usableVolumeCtrl, "Useable Volume Calculate from LowLevel float to basin water level when full", AppController.inputInfo.onUseableVolumeChange),
              GeneralInput("ft", "[D] Useable Volume Height", AppController.inputInfo.usableVolumeHeightCtrl, "Height of Usable Volume", AppController.inputInfo.onUseableVolumeHeightChange),
              GeneralInput("in", "[E] lag float  ↔ water level", AppController.inputInfo.lagFloatHeightCtrl, "Distance from lag pump float to water level", AppController.inputInfo.onLagToWaterLevelChange),
              GeneralInput("in", "[F] water level  ↔ inlet (>2)", AppController.inputInfo.waterLevelToInletHeightCtrl, "Distance from basin water level to bottom of pipe inlet", AppController.inputInfo.onWaterLevelToInlet),
              GeneralInput("in", "[H] inlet  ↔ surface", AppController.inputInfo.inletToSurfaceHeightCtrl, "Distance from bottom of pipe inlet to surface", AppController.inputInfo.onInlettoSuraceHeightChange),
              GeneralInput("ft", "[M] depth basin", AppController.inputInfo.basinDepthCtrl, "Depth basin", AppController.inputInfo.onDepthBasinChange),
              GeneralInput("ft", "[S] total structure height", AppController.inputInfo.totalStructuralDepthCtrl, "Depth included the thickness of basin base to surface", AppController.inputInfo.onTotalStructureHeightChange),
              
              GeneralInput("ft", "[T] Basin Floor Sealevel", AppController.inputInfo.basinFloorSealevelCtrl, "Basin floor Sea Level", AppController.inputInfo.onBasinFloorAreaChange),
              
              GeneralInput("ft", "[R] static head", AppController.inputInfo.staticHeadCtrl, "Static Head", AppController.inputInfo.onStaticHeadChange),
              GeneralInput("ft", "[K] out pipe to finished surface", AppController.inputInfo.outPipeToFinishedSurfaceCtrl, "Distance from pipe just going out of basin to surface", AppController.inputInfo.onOutPipeToSurfaceChange),
              GeneralInput("in", "[O] valve box depth", AppController.inputInfo.valveBoxDepthCtrl, "Valve Box Depth", AppController.inputInfo.onValveBoxDepthChange),
            ]
          ),

        ],
      ),
    );
  }

}