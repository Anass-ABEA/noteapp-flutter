// @dart=2.9
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/colors.dart';

class Note{
   bool selected = false;
   String title;
    String content;
    DateTime date;
    Color textColor;
    Color bgColor;
   List<String> category = [];

  Note(this.title, this.content, this.date, this.textColor, this.bgColor);
  Note.extras(this.title, this.content, this.date, this.textColor, this.bgColor,this.category);

  Note.empty(){
    this.bgColor = Colors.blue;
    this.textColor = Colors.black;
  }

  Note.fromJSON(Map<String, dynamic> json) {
    this.title = json["title"];
    this.content = json["content"];
    this.date = DateTime.parse(json["date"]);
    this.textColor = MyColors.hexToColor(json["textColor"]);
    this.bgColor = MyColors.hexToColor(json["bgColor"]);
    this.category = List<String>.from(json["category"]);

  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> res = new Map<String, dynamic>();
    res.putIfAbsent("title", () => title);
    res.putIfAbsent("date", () => date.toString());
    res.putIfAbsent("content", () => content);
    res.putIfAbsent("bgColor", () => MyColors.colorToHexString(bgColor));
    res.putIfAbsent("textColor", () => MyColors.colorToHexString(textColor));
    res.putIfAbsent("category", () => category);
    return res;
  }

  @override
  bool operator == (Object other) {
      Note note = other as Note;
      return note.category == this.category && note.textColor == this.textColor && this.bgColor == note.bgColor && this.content == note.content && this.date  == note.date;
  }
}