import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:my_app/calc/app_controller.dart';

class SystemPumpChart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ListChartSeries lcs = ListChartSeries();


    List<charts.Series<DataSeries, double>> series = [
      charts.Series(
        id: "developers",
        data: lcs.pumpCurveData,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color,
        displayName: "abc",
        ),
        charts.Series(
        id: "developers",
        data: lcs.systemCurveData,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color
        ),

        charts.Series(
        id: "developers",
        data: lcs.horizontalData,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color,
        ),

        charts.Series(
        id: "developers",
        data: lcs.inflowData,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color
        ),

        charts.Series(
        id: "developers",
        data: lcs.pointData,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color
        )..setAttribute(charts.rendererIdKey, "dots"),        
    ];

    List anotation = [];
    anotation.add(
      charts.LineAnnotationSegment(
        AppController.structInfo.inflow, charts.RangeAnnotationAxisType.domain,
        startLabel: "${AppController.structInfo.inflow.toStringAsFixed(2)} gpm",
        labelDirection: charts.AnnotationLabelDirection.horizontal,
        labelPosition: charts.AnnotationLabelPosition.auto,
        labelAnchor: charts.AnnotationLabelAnchor.start,
      ),
    );

    if(AppController.sewageES.pumpRate != -1){
      anotation.add(
        charts.LineAnnotationSegment(
          AppController.sewageES.hn + AppController.structInfo.staticHead,
          charts.RangeAnnotationAxisType.measure,
          startLabel: "hn + hs = ${(AppController.sewageES.hn + AppController.structInfo.staticHead).toStringAsFixed(2)} ft",
          labelDirection: charts.AnnotationLabelDirection.horizontal,
          labelAnchor: charts.AnnotationLabelAnchor.start,

        ),
      );

      anotation.add(
        charts.LineAnnotationSegment(
          AppController.sewageES.pumpRate,
          charts.RangeAnnotationAxisType.domain,
          endLabel: "${AppController.sewageES.pumpRate.toStringAsFixed(2)} gpm",
          labelDirection: charts.AnnotationLabelDirection.horizontal,
          labelAnchor: charts.AnnotationLabelAnchor.start,
        ),
      );
    }

    

    return RepaintBoundary(
      key: AppController.key,
      child: charts.LineChart(
        series,
        animate: false,
        defaultRenderer: charts.LineRendererConfig(includePoints: false),
        behaviors: [
          charts.RangeAnnotation([
            ...anotation
          ]
          ),
          charts.ChartTitle(
            "feet",
            behaviorPosition: charts.BehaviorPosition.start,
          ),
          charts.ChartTitle(
            "gpm",
            behaviorPosition: charts.BehaviorPosition.bottom,
            
          ),
        ],
        customSeriesRenderers: [
          charts.PointRendererConfig(
            customRendererId: 'dots'
          )
        ],

      ),
    );
  } 

}




class ListChartSeries{
  List<DataSeries> pumpCurveData = [];
  List<DataSeries> systemCurveData = [];
  List<DataSeries> pointData = [];
  List<DataSeries> horizontalData = [];
  List<DataSeries> inflowData = [];

  ListChartSeries(){
    pumpCurveData.clear();
    systemCurveData.clear();
    pointData.clear();
    horizontalData.clear();
    inflowData.clear();

    Map<double, double> pumpCurve = AppController.sewageES.impeller.feetGal;
    pumpCurve.forEach((key, value) {
      DataSeries ds = DataSeries(key, value, charts.ColorUtil.fromDartColor(Colors.blue));
      pumpCurveData.add(ds);
    });

    Map<double, double> systemCurve = AppController.sewageES.systemCurve;
    systemCurve.forEach((key, value) {
      DataSeries ds = DataSeries(key, value, charts.ColorUtil.fromDartColor(Colors.orange));
      systemCurveData.add(ds);
    });

    if(AppController.sewageES.pumpRate != -1){
      DataSeries ds = DataSeries(AppController.sewageES.pumpRate, AppController.sewageES.hn + AppController.structInfo.staticHead, charts.ColorUtil.fromDartColor(Colors.red));
      pointData.add(ds);

      //Create Horizontal
      DataSeries ds1 = DataSeries(0, AppController.sewageES.hn + AppController.structInfo.staticHead, charts.ColorUtil.fromDartColor(Colors.green));
      DataSeries ds2 = DataSeries(AppController.sewageES.pumpRate, AppController.sewageES.hn + AppController.structInfo.staticHead, charts.ColorUtil.fromDartColor(Colors.green));
      DataSeries ds3 = DataSeries(AppController.sewageES.pumpRate, 0, charts.ColorUtil.fromDartColor(Colors.green));
      horizontalData.addAll([ds1, ds2, ds3]);
    }

    double highest1 = max(AppController.sewageES.impeller.feetGal.values.first, AppController.sewageES.systemCurve.values.first);
    double highest2 = max(AppController.sewageES.impeller.feetGal.values.last, AppController.sewageES.systemCurve.values.last);
    double highest  = max(highest1, highest2);

    DataSeries ds4 = DataSeries(AppController.structInfo.inflow, 0, charts.ColorUtil.fromDartColor(Colors.brown));
    DataSeries ds5 = DataSeries(AppController.structInfo.inflow, highest, charts.ColorUtil.fromDartColor(Colors.brown));
    inflowData.addAll([ds4, ds5]);
  }
}

class DataSeries{
  final double x;
  final double y;
  final charts.Color color;
  DataSeries(this.x, this.y, this.color);
}