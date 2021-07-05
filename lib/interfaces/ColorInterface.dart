// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/states/ColorState.dart';

class ColorInterface extends StatefulWidget{

  Color color;
  bool newColor;
  bool isTextColor;
  ColorInterface(){
    color = Colors.blue;
    newColor = true;
    isTextColor = false;
  }
  ColorInterface.update(this.color){
    newColor = false;
    isTextColor = false;
  }

  ColorInterface.updateText(this.color){
    newColor = false;
    isTextColor = true;
  }

  @override
  ColorState createState() => ColorState(color,newColor,isTextColor);


}

