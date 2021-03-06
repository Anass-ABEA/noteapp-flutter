// @dart=2.9

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/colors.dart';
import 'package:flutter_app1/interfaces/ColorInterface.dart';
import 'package:localstorage/localstorage.dart';

class ColorState extends State<ColorInterface> {
  final LocalStorage storage = LocalStorage("notes");
  Color color;
  Color oldColor;
  bool newColor;
  bool isTextColor;

  ColorState(this.color, this.newColor,this.isTextColor) {
    this.oldColor = color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newColor ? "New Color" : "Update Color"),
        backgroundColor: color,
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color),
                overlayColor: MaterialStateProperty.all(color),
                foregroundColor: MaterialStateProperty.all(color),
                shadowColor: MaterialStateProperty.all(color),
              ),
              onPressed: () {
                saveColor();
              },
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(2000)),
                child: Icon(
                  Icons.check,
                  color: Colors.greenAccent,
                  size: 30,
                ),
              ))
        ],
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Visibility(child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Change Text Color", style: TextStyle(fontSize: 17,),),
              Switch(
                value: isTextColor,
                onChanged: (bool val){
                  setState(() {
                    isTextColor = val;
                  });
                },

              )
            ],
          ),visible: newColor,),
          ColorPicker(
            color: color,
            pickersEnabled: <ColorPickerType, bool>{
              ColorPickerType.wheel: true,
              ColorPickerType.bw: false,
              ColorPickerType.primary: false,
              ColorPickerType.custom: false,
              ColorPickerType.accent: false,
            },
            onColorChanged: (Color value) {
              print(value);
              setState(() {
                this.color = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(child: Container(
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(10),
                width: 50,
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "NEW",
                      style: TextStyle(fontFamily: "RobotoSlab"),
                    )
                  ],
                ),
              ),visible: !isTextColor,),
              Visibility(child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(10),
                width: 50,
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "NEW",
                      style: TextStyle(fontFamily: "RobotoSlab",color: color),
                    )
                  ],
                ),
              ),visible: isTextColor,),
              Visibility(
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 50,
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "OLD",
                        style: TextStyle(fontFamily: "RobotoSlab"),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: oldColor, borderRadius: BorderRadius.circular(10)),
                ),
                visible: !newColor && !isTextColor,
              ),
              Visibility(
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 50,
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "OLD",
                        style: TextStyle(fontFamily: "RobotoSlab",color: oldColor),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                ),
                visible: !newColor && isTextColor,
              )
            ],
          ),

        ],
      ),
    );
  }

  void saveColor() {
    String saveTo ="colors";
    if(isTextColor) saveTo = "textColors";
    if (newColor) {
      List<String> stringColors = [];
      if (storage.getItem(saveTo) != null) {
        stringColors = List<String>.from(storage.getItem(saveTo));
      }
      stringColors.add(MyColors.colorToHexString(color));
      storage.setItem(saveTo, stringColors);
    } else {
      List<String> stringColors = List<String>.from(storage.getItem(saveTo));
      int pos = stringColors.indexOf(MyColors.colorToHexString(oldColor));
      stringColors.removeAt(pos);
      stringColors.add(MyColors.colorToHexString(color));
      storage.setItem(saveTo, stringColors);
    }
    Navigator.pop(context);
  }
}
