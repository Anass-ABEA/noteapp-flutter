// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/interfaces/CategoryInterface.dart';
import 'package:flutter_app1/interfaces/CategoryListInterface.dart';
import 'package:localstorage/localstorage.dart';

class CategoryListState extends State<CategoryListInterface> {
  List<String> categories;
  int len = 0;
  final LocalStorage storage = new LocalStorage('notes');

  @override
  void initState() {
    super.initState();
    getCategoriesFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(33, 103, 243, 1.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(136, 208, 239, 0.8),
                blurRadius: 12,
                spreadRadius: 4)
          ],
        ),
        child: Container(
          child: ListView.builder(
            itemCount: len,
            itemBuilder: (BuildContext context, int index) {
              String cat = categories[index];
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Colors.white, width: 5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      width: 50,
                      height: 50,
                      child: Text(cat),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(33, 103, 243, 1.0)),
                              overlayColor: MaterialStateProperty.all(
                                  Color.fromRGBO(33, 103, 243, 1.0)),
                              foregroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(33, 103, 243, 1.0)),
                              shadowColor: MaterialStateProperty.all(
                                  Color.fromRGBO(33, 103, 243, 1.0)),
                            ),
                            onPressed: () {
                              setState(() {
                                categories.removeAt(index);
                                len--;
                              });
                              storage.setItem("categ", categories);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Color.fromRGBO(255, 0, 0, 1),
                                ),
                                Text(
                                  "Remove",
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 0, 0, 1),
                                  ),
                                )
                              ],
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(33, 103, 243, 1.0)),
                              overlayColor: MaterialStateProperty.all(
                                  Color.fromRGBO(33, 103, 243, 1.0)),
                              foregroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(33, 103, 243, 1.0)),
                              shadowColor: MaterialStateProperty.all(
                                  Color.fromRGBO(33, 103, 243, 1.0)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryInterface.update(cat)))
                                  .then((value) => getCategoriesFromStorage());
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Color.fromRGBO(0, 255, 0, 1),
                                ),
                                Text("Edit",
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 255, 0, 1),
                                    ))
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoryInterface()))
              .then((value) => getCategoriesFromStorage());
        },
        label: Text("Add Category"),
        icon: Icon(Icons.add),
      ),
    );
  }

  getCategoriesFromStorage() async {
    await storage.ready.then((e) {
      List<String> list = [];
      if (storage.getItem("categ") != null) {
        list = List<String>.from(storage.getItem("categ"));
        storage.setItem("categ", []);
      }
      setState(() {
        categories = list;
      });
      print(categories);
    });
  }
}
