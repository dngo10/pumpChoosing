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
        data: lcs.data,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color,
        displayName: "6 inch",
        ),
        charts.Series(
        id: "developers",
        data: lcs.data1,
        domainFn: (DataSeries series, _) => series.x,
        measureFn: (DataSeries series, _) => series.y,
        colorFn: (DataSeries series, _) => series.color
        )..setAttribute(charts.rendererIdKey, "dots")
    ];

    

    return charts.LineChart(
      series,
      animate: true,
      defaultRenderer: charts.LineRendererConfig(includePoints: true),
      behaviors: [
        charts.RangeAnnotation([
          charts.LineAnnotationSegment(
            50, charts.RangeAnnotationAxisType.domain, startLabel: 'abc'
          ),
          charts.LineAnnotationSegment(
            60, charts.RangeAnnotationAxisType.domain, endLabel: 'abc', labelDirection: charts.AnnotationLabelDirection.horizontal
          ),
          charts.LineAnnotationSegment(
            28, charts.RangeAnnotationAxisType.measure, startLabel: 'abc'
          ),
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

    );
  } 

}




class ListChartSeries{
  List<DataSeries> data = [];
  List<DataSeries> data1 = [];

  ListChartSeries(){
    Map<double, double> temp = AppController.pumpData.pumpList.first.impellerList.first.feetGal;
    temp.forEach((key, value) {
      DataSeries ds = DataSeries(key, value, charts.ColorUtil.fromDartColor(Colors.green));
      data.add(ds);
    });

    Map<double, double> temp1 = AppController.pumpData.pumpList.first.impellerList[1].feetGal;
    temp1.forEach((key, value) {
      DataSeries ds = DataSeries(key, value, charts.ColorUtil.fromDartColor(Colors.red));
      data1.add(ds);
    });
  }
}

class DataSeries{
  final double x;
  final double y;
  final charts.Color color;
  DataSeries(this.x, this.y, this.color);
}