import 'package:flutter/cupertino.dart';
import 'dart:math' as Math;

class Design{

  final String fontFamily = 'jf';
  final double designWidth = 2160;
  final double designHeight = 1620;

  double sizeHorizontal(BuildContext context, double originSize) {
    return originSize * MediaQuery.of(context).size.width / designWidth;
  }

  double sizeVertical(BuildContext context, double originSize) {
    return originSize * MediaQuery.of(context).size.height / designHeight;
  }

  double fontExchange(BuildContext context, double originSize) {
    double widthSize = sizeHorizontal(context, 1);
    double heightSize = sizeVertical(context, 1);
    return Math.min(widthSize, heightSize) * originSize;
  }

}

class WebDesign{

  final String fontFamily = 'jf';
  final double designWidth = 1366;
  final double designHeight = 768;

  double sizeHorizontal(BuildContext context, double originSize) {
    return originSize * MediaQuery.of(context).size.width / designWidth;
  }

  double sizeVertical(BuildContext context, double originSize) {
    return originSize * MediaQuery.of(context).size.height / designHeight;
  }

  double fontExchange(BuildContext context, double originSize) {
    double widthSize = sizeHorizontal(context, 1);
    double heightSize = sizeVertical(context, 1);
    return Math.min(widthSize, heightSize) * originSize;
  }

}
