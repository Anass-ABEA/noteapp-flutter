import 'dart:ui';

import 'package:flutter/material.dart';

class MyColors{
  static hexToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static colorToHexString(Color color) {
    return '#FF${color.value.toRadixString(16).substring(2, 8)}';
  }
  static List<Color> listColorsFromListHex(List<String> hexCodeList){
    List<Color> res = <Color>[];
    for(String hexColor in hexCodeList){
      res.add(hexToColor(hexColor));
    }
    return res;
  }

  static List<String> listHexFromColor(List<Color> colorList){
    List<String> res = <String>[];
    for(Color hexColor in colorList){
      res.add(colorToHexString(hexColor));
    }
    return res;
  }


}