import 'dart:math';

import 'package:my_app/calc/charts/point.dart';

class Helper{
  static bool hasIntersection(Point p1, Point p2, Point p3, Point p4){
    var I1 = [min(p1.x, p2.x), max(p1.x, p2.x)];
    var I2 = [min(p3.x, p4.x), max(p3.x, p4.x)];

    var Ia = [max(min(p1.x, p2.x), min(p3.x, p4.x)), min(max(p1.x, p2.x), max(p3.x, p4.x))];

    if(max(p1.x, p2.x) < min(p3.x, p4.x)) return false;
    //https://stackoverflow.com/questions/3838329/how-can-i-check-if-two-segments-intersect
    //https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/

  }
}