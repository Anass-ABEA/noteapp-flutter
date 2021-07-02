import 'dart:ui';

import 'package:flutter_app1/classes/colors.dart';

class Note{
  late bool selected = false;
  late final String title;
  late final String content;
  late final DateTime date;
  late final Color textColor;
  late final Color bgColor;
  late String category = "";

  Note(this.title, this.content, this.date, this.textColor, this.bgColor);
  Note.extras(this.title, this.content, this.date, this.textColor, this.bgColor,this.category);

  Note.fromJSON(Map<String, dynamic> json) {

    this.title = json["title"];
    this.content = json["content"];
    this.date = DateTime.parse(json["date"]);
    this.textColor = MyColors.hexToColor(json["textColor"]);
    this.bgColor = MyColors.hexToColor(json["bgColor"]);
    this.category = json["category"];

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





}