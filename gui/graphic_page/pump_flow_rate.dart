import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:my_app/calc/app_controller.dart';

class PumpFlowRate extends StatefulWidget{
  const PumpFlowRate({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {

    return _PumpFlowRate();
  }
}

class _PumpFlowRate extends State<PumpFlowRate>{
  @override
  Widget build(BuildContext context) {
    ListChartSeries lcs = ListChartSeries();

    List<charts.Series<DataSeries, double>> series = [
      charts.Series(
        id: "a",
        data: lcs.pumpRate,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color,
      ),

      charts.Series(
        id: "b",
        data: lcs.min1,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color,
      ),

      charts.Series(
        id: "c",
        data: lcs.min2,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color,
      ),

      charts.Series(
        id: "d",
        data: lcs.min3,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color,
      ),

      charts.Series(
        id: "e",
        data: lcs.min4,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color,
      ),

      charts.Series(
        id: "f",
        data: lcs.min5,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color,
      ),
    ];

    return charts.LineChart(
      series,
      defaultRenderer: charts.LineRendererConfig(includePoints: false),
      animate: false,
      behaviors: [
        charts.RangeAnnotation([
          charts.LineAnnotationSegment(
            AppController.structInfo.inflow*9/1,
            charts.RangeAnnotationAxisType.domain,
            startLabel: "1 min",
            labelDirection: charts.AnnotationLabelDirection.horizontal,
            labelAnchor: charts.AnnotationLabelAnchor.start,
          ),

          charts.LineAnnotationSegment(
            AppController.structInfo.inflow*8/2,
            charts.RangeAnnotationAxisType.domain,
            startLabel: "2 min",
            labelDirection: charts.AnnotationLabelDirection.horizontal,
            labelAnchor: charts.AnnotationLabelAnchor.start,
          ),

          charts.LineAnnotationSegment(
            AppController.structInfo.inflow*7/3,
            charts.RangeAnnotationAxisType.domain,
            startLabel: "3 min",
            labelDirection: charts.AnnotationLabelDirection.horizontal,
            labelAnchor: charts.AnnotationLabelAnchor.start,
          ),

          charts.LineAnnotationSegment(
            AppController.structInfo.inflow*5/4,
            charts.RangeAnnotationAxisType.domain,
            endLabel: "4 min",
            labelDirection: charts.AnnotationLabelDirection.horizontal,
            labelAnchor: charts.AnnotationLabelAnchor.start,
          ),

          charts.LineAnnotationSegment(
            AppController.structInfo.inflow,
            charts.RangeAnnotationAxisType.domain,
            startLabel: "5 min",
            labelDirection: charts.AnnotationLabelDirection.horizontal,
            labelAnchor: charts.AnnotationLabelAnchor.start,
          ),
        ]),
        charts.ChartTitle(
          "pump rate (GPM)",
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea
        ),

        charts.ChartTitle(
          "sump depth (ft)",
          behaviorPosition: charts.BehaviorPosition.start,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea
        ),
      ],
    );
  }
}

class ListChartSeries{
  List<DataSeries> min1 = [];
  List<DataSeries> min2 = [];
  List<DataSeries> min3 = [];
  List<DataSeries> min4 = [];
  List<DataSeries> min5 = [];
  List<DataSeries> pumpRate = [];

  ListChartSeries(){

    min1.clear();
    min2.clear();
    min3.clear();
    min4.clear();
    min5.clear();
    pumpRate.clear();

    if(AppController.sewageES.pumpRateCurve.isEmpty){
      return;
    }

    AppController.sewageES.pumpRateCurve.forEach((key, value) {
      DataSeries ds = DataSeries(key, value, charts.ColorUtil.fromDartColor(Colors.blue));
      pumpRate.add(ds);
    });



    double maxValue = max(AppController.sewageES.pumpRateCurve.values.first, AppController.sewageES.pumpRateCurve.values.last) + 4;
    double qf = AppController.structInfo.inflow;
    DataSeries ds1_1 = DataSeries(qf*9/1, 0, charts.ColorUtil.fromDartColor(Colors.green));
    DataSeries ds1_2 = DataSeries(qf*9/1, maxValue, charts.ColorUtil.fromDartColor(Colors.green));
    min1.addAll([ds1_1, ds1_2]);

    DataSeries ds2_1 = DataSeries(qf*8/2, 0, charts.ColorUtil.fromDartColor(Colors.pink));
    DataSeries ds2_2 = DataSeries(qf*8/2, maxValue, charts.ColorUtil.fromDartColor(Colors.pink));
    min2.addAll([ds2_1, ds2_2]);

    DataSeries ds3_1 = DataSeries(qf*7/3, 0, charts.ColorUtil.fromDartColor(Colors.yellow));
    DataSeries ds3_2 = DataSeries(qf*7/3, maxValue, charts.ColorUtil.fromDartColor(Colors.yellow));
    min3.addAll([ds3_1, ds3_2]);


    DataSeries ds4_1 = DataSeries(qf*5/4, 0, charts.ColorUtil.fromDartColor(Colors.purple));
    DataSeries ds4_2 = DataSeries(qf*5/4, maxValue, charts.ColorUtil.fromDartColor(Colors.purple));
    min4.addAll([ds4_1, ds4_2]);

    DataSeries ds5_1 = DataSeries(qf*1, 0, charts.ColorUtil.fromDartColor(Colors.brown));
    DataSeries ds5_2 = DataSeries(qf*1, maxValue, charts.ColorUtil.fromDartColor(Colors.brown));
    min5.addAll([ds5_1, ds5_2]);
  }

}

class DataSeries{
  final double x;
  final double y;
  final charts.Color color;

  DataSeries(this.x, this.y, this.color);
}