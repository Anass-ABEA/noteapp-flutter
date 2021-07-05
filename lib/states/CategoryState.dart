// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/interfaces/CategoryInterface.dart';
import 'package:localstorage/localstorage.dart';

class CategoryState extends State<CategoryInterface> {
  final LocalStorage storage = new LocalStorage('notes');
  String category;
  bool newCategory;
  String oldCategory;

  CategoryState(this.category, this.newCategory) {
    this.oldCategory = category;
  }

  /*
  Scaffold(
      appBar: AppBar(
        title: Text(newCategory ? "New Category" : "Update Category"),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                overlayColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.blue),
                shadowColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () {
                saveCategory();
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                initialValue: category,
                onChanged: (String val){
                  setState(() {
                    category = val;
                  });
                },
                style: TextStyle(fontFamily: "RobotoSlab"),
                decoration: const InputDecoration(
                  hintText: 'Enter Category',
                  labelText: "Category",
                ),

              ),
            ),
          ],
        ),
      ),
    )
  * */

  setCategory(String val) {
    setState(() {
      category = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return true;},
      child: Scaffold(
        appBar: AppBar(
          title: Text(newCategory ? "New Category" : "Update Category"),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  overlayColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.blue),
                  shadowColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  saveCategory();
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
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(150, 150, 150, 0.8),
                        blurRadius: 12,
                        spreadRadius: 4)
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      TextFormField(
                        initialValue: category,
                        onChanged: setCategory,
                        style: TextStyle(fontFamily: "RobotoSlab"),
                        decoration: const InputDecoration(
                          hintText: 'Add Category',
                          labelText: "Category",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveCategory() {
    if (newCategory) {
      List<String> stringCategories = [];
      if (storage.getItem("categ") != null) {
        stringCategories = List<String>.from(storage.getItem("categ"));
      }
      stringCategories.add(category);
      storage.setItem("categ", stringCategories);
    } else {
      List<String> stringColors =
          List<String>.from(storage.getItem("categ"));
      int pos = stringColors.indexOf(category);
      stringColors.removeAt(pos);
      stringColors.add(category);
      storage.setItem("categ", stringColors);
    }
    Navigator.pop(context);
  }
}
