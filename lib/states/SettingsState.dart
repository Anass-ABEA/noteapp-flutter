// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/colors.dart';
import 'package:flutter_app1/interfaces/ColorInterface.dart';
import 'package:flutter_app1/interfaces/SettingsInterface.dart';
import 'package:localstorage/localstorage.dart';

class SettingsState extends State<SettngsInterface> {
  List<Color> colorList;
  int len = 0;
  final LocalStorage storage = new LocalStorage('notes');

  @override
  void initState() {
    super.initState();
    getColorsFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
              Color c = colorList[index];
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
                          color: c,
                          borderRadius: BorderRadius.circular(5)),
                      width: 50,
                      height: 50,
                      child: Text(""),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(Color.fromRGBO(33, 103, 243, 1.0)),
                            overlayColor: MaterialStateProperty.all(Color.fromRGBO(33, 103, 243, 1.0)),
                            foregroundColor: MaterialStateProperty.all(Color.fromRGBO(33, 103, 243, 1.0)),
                            shadowColor: MaterialStateProperty.all(Color.fromRGBO(33, 103, 243, 1.0)),
                          ),
                            onPressed: () {
                              setState(() {
                                colorList.removeAt(index);
                                len--;
                              });
                              getColorsFromStorage();
                              storage.setItem("colors",
                                  MyColors.listHexFromColor(colorList));
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
                              backgroundColor: MaterialStateProperty.all(Color.fromRGBO(33, 103, 243, 1.0)),
                              overlayColor: MaterialStateProperty.all(Color.fromRGBO(33, 103, 243, 1.0)),
                              foregroundColor: MaterialStateProperty.all(Color.fromRGBO(33, 103, 243, 1.0)),
                              shadowColor: MaterialStateProperty.all(Color.fromRGBO(33, 103, 243, 1.0)),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ColorInterface.update(c))).then((value) => getColorsFromStorage());

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
              MaterialPageRoute(builder: (context) => ColorInterface())).then((value) => getColorsFromStorage());
        },
        label: Text("Add Color"),
        icon: Icon(Icons.add),
      ),
    );
  }

  getColorsFromStorage() async {
    await storage.ready.then((e) {
      List<String> stringColors;
      if (storage.getItem("colors") != null)
        stringColors = List<String>.from(storage.getItem("colors"));

      if (stringColors == null || stringColors.length == 0) {
        List<Color> colorsList = <Color>[
          Colors.blue,
          Colors.yellow,
          Colors.orange
        ];
        storage.setItem("colors", MyColors.listHexFromColor(colorsList));
      }
      setState(() {
        colorList = MyColors.listColorsFromListHex(stringColors);
        len = colorList.length;
      });
    });
  }
}
