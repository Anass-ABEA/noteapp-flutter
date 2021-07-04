// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/states/ColorState.dart';

class ColorInterface extends StatefulWidget{

  Color color;
  bool newColor;
  ColorInterface(){
    color = Colors.blue;
    newColor = true;
  }
  ColorInterface.update(this.color){
    newColor = false;
  }

  @override
  ColorState createState() => ColorState(color,newColor);


}

