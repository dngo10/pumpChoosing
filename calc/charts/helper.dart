import 'dart:math' as math;

import 'package:my_app/calc/charts/point.dart';

class Helper{
  static bool hasIntersection(Point p1, Point p2, Point p3, Point p4, Point intersect){

    var ia = [math.max(math.min(p1.x, p2.x), math.min(p3.x, p4.x)), math.min(math.max(p1.x, p2.x), math.max(p3.x, p4.x))];

    if(math.max(p1.x, p2.x) < math.min(p3.x, p4.x)) return false;

    var a1 = (p1.y-p2.y)/(p1.x-p2.x); // Pay attention to not dividing by zero
    var a2 = (p3.y-p4.y)/(p3.x-p4.x); // Pay attention to not dividing by zero
    var b1 = p2.y-a1*p2.x;
    var b2 = p3.y-a2*p3.x;

    if((a1 - a2).abs() < 0.000001){
      return false;
    }

    var xa = (b2 - b1) / (a1 - a2);
    var ya = a1 * xa + b1;

    if ((xa < ia[0]) || (xa > ia[1])){
      return false; // intersection is out of bound
    }else{
      intersect.x = xa;
      intersect.y = ya;
      return true;
    }
    //https://stackoverflow.com/questions/3838329/how-can-i-check-if-two-segments-intersect
    //https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
  }

  static List<Point> getListPoint(Map<double, double> map){
    List<Point> points = [];
    map.forEach((key, value) {
      Point p = Point.setVal(key, value);
      points.add(p);
    });    
    return points;
  }

  static Point? getInterSecionOf2Map(Map<double, double> line1, Map<double, double> line2){
    List<Point> lineP1 = getListPoint(line1);
    List<Point> lineP2 = getListPoint(line2);

    return getIntersectionOf2Line(lineP1, lineP2);
  }

  static Point? getIntersectionOf2Line(List<Point> p1, List<Point>p2){
    for(int i = 0; i < p1.length - 1; i++){
      for(int j = 0; j < p2.length -1; j++){
        Point intersection = Point();
        if(hasIntersection(p1[i], p1[i+1], p2[j], p2[j+1], intersection)){
          return intersection;
        }
      }
    }
  }
}