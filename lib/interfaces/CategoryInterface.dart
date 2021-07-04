// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/states/CategoryState.dart';

class CategoryInterface extends StatefulWidget{

  String category;
  bool newCategory;
  CategoryInterface(){
    category = "";
    newCategory = true;
  }
  CategoryInterface.update(this.category){
    newCategory = false;
  }

  @override
  CategoryState createState() => CategoryState(category,newCategory);


}

