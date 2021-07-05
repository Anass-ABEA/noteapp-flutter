// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/Note.dart';
import 'package:flutter_app1/classes/colors.dart';
import 'package:flutter_app1/interfaces/NewNoteInterface.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:localstorage/localstorage.dart';

import '../main.dart';

class NewNoteState extends State<NewNoteInterface> {
  Note note;
  bool isNew = true;
  String title;
  int elementIndex;
  List<Color> colorList = [];
  List<Color> textColorsList = [];
  final LocalStorage storage = new LocalStorage('notes');

  List<String> getCategories() {
    List<String> res = <String>[" "];

    if (storage.getItem("categories") != null)
      res.addAll(List<String>.from(storage.getItem("categories")));

    return res;
  }

  getColorsFromStorage()async{
    List<String> stringColors;
    await storage.ready.then((e){
      if (storage.getItem("colors") != null)
        stringColors = List<String>.from(storage.getItem("colors"));

      if (stringColors == null) {
        List<Color> colorsList = <Color>[
          Colors.blue,
          Colors.yellow,
          Colors.orange
        ];
        storage.setItem("colors", MyColors.listHexFromColor(colorsList));
        return colorsList;
      }

    });
  }



  NewNoteState(Note note,this.elementIndex) {

    if(note == null){
      this.note = Note.empty();
    }else{
      this.note = note;
    }
    isNew = ( this.note.date == null );
    if(isNew){
      this.title = "New Note";
    }else{
      this.title = "Update Note";
    }
    print("is NEW ? "+isNew.toString()+ " INDEX IS "+ elementIndex.toString());
  }

  setNoteTitle(String title) {
    setState(() {
      this.note.title = title;
    });
  }

  setNoteContent(String content) {
    setState(() {
      this.note.content = content;
    });
  }

  setColor(Color color) {
    setState(() {
      this.note.bgColor = color;
    });
  }

  saveNewNote() {
    setState(() {
      note.category.remove("NONE");
      note.date = DateTime.now();
    });

    if (note.title.length == 0 && note.content.length == 0) {
      final snackBar = SnackBar(
        content: Text('The note is empty!'),
        duration: Duration(milliseconds: 700),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      List<Map<String, dynamic>> list = [];
      if (storage.getItem("list") != null) {
        list = List<Map<String, dynamic>>.from(storage.getItem("list"));
        if(isNew){
          list.insert(0, note.toJSON());
        }else{
          list.removeAt(elementIndex);
          list.insert(0, note.toJSON());
        }
      }

      storage.setItem("list", list);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyApp(0)));
    }

    print(note.toString());
  }

  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: KeyboardVisibilityBuilder(builder: (ctx,isOPen)=>
            Scaffold(
              drawer: Container(
                child: Wrap(
                  children: [
                    Text("Card Color :",style: TextStyle(color:Colors.white,fontSize: 25),),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: colorList
                          .map((e) => Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          child: Text(
                            "",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            setColor(e);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(e)),
                        ),
                      ))
                          .toList(),
                    ),
                    Text("Text Color: ",style: TextStyle(color:Colors.white,fontSize: 25),),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: textColorsList
                          .map((e) => Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          child: Text(
                            "",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              note.textColor = e;
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(e)),
                        ),
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(title),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        saveNewNote();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2000)),
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
                      margin: EdgeInsets.fromLTRB(30, 40, 30, isOPen? 10:30),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(150, 150, 150, 0.8),
                              blurRadius: 12,
                              spreadRadius: 4)
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: note.bgColor,
                      ),
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            Visibility(child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Add categories: "),
                                DropdownButton(
                                  value: _value,
                                  items: getCategories()
                                      .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: getCategories().indexOf(e),
                                  ))
                                      .toList(),
                                  onChanged: (int value) {
                                    setState(() {
                                      _value = value;
                                      if (value != 0)
                                        note.addCategory(getCategories()[value]);
                                    });
                                  },
                                )
                              ],
                            ),
                              visible: false,),
                            TextFormField(

                              cursorColor: note.textColor,
                              initialValue: note.title,
                              onChanged: setNoteTitle,
                              style: TextStyle(fontFamily: "RobotoSlab",color: note.textColor),
                              decoration: const InputDecoration(

                                hintText: 'Note title (optional)',
                                labelText: "Note Title",
                              ),

                            ),

                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: TextFormField(
                                  cursorColor: note.textColor,
                                  initialValue: note.content,
                                  style: TextStyle(fontFamily: "RobotoSlab",color: note.textColor),
                                  onChanged: setNoteContent,
                                  maxLines: null,
                                  minLines: null,
                                  expands: true,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      hintText: 'Note Body',
                                      labelText: "Note Body",
                                      alignLabelWithHint: true,
                                      hintStyle: TextStyle(height: 1.2))),
                            ),
                           /* Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: colorList
                                  .map((e) => Flexible(
                                flex: 1,
                                child: ElevatedButton(
                                  child: Text(
                                    "",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    setColor(e);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(e)),
                                ),
                              ))
                                  .toList(),
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: textColorsList
                                  .map((e) => Flexible(
                                flex: 1,
                                child: ElevatedButton(
                                  child: Text(
                                    "",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      note.textColor = e;
                                    });
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(e)),
                                ),
                              ))
                                  .toList(),
                            ),*/
                            Visibility(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Text Color"),
                                      ElevatedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                  note.textColor)),
                                          child: Container(
                                            color: Colors.black,
                                          )),
                                      Text("Background Color"),
                                      ElevatedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                  note.bgColor)),
                                          child: Container(
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Preview"),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        color: note.bgColor,
                                        child: Text(
                                          "ABC",
                                          style: TextStyle(
                                              color: note.textColor, fontSize: 20),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              visible: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      child: Visibility(
                          visible: false,
                          child:Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: note.bgColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    child: Text("Categories: "),
                                    padding: EdgeInsets.only(right: 10, top: 15),
                                  ),
                                  Container(
                                    width: 120,
                                    child: displayCategoryWidget(),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                      top: 15,
                      left: 30,
                    ),
                  ],
                ),
              ),
            ),),
        onWillPop: () async {
          if (note.title.length != 0 || note.content.length != 0) {
            print("NOT EMPTY");
            var snackBar = SnackBar(
              content: Text('Are you sure you want to leave?'),
              action: SnackBarAction(
                label: "Yes",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp(0)));
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return false;
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp(0)));
          return true;
        });
  }

  displayCategoryWidget() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: note.category.length,
        itemBuilder: (BuildContext bc, int index) {
          String e = note.category[index];
          return FlatButton(
              onPressed: () {
                setState(() {
                  note.category.removeAt(index);
                  if (note.category.length == 0) note.category.add("NONE");
                });
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Text(
                  e,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: "RobotoSlab"),
                ),
              ));
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadColorsFromStorage();
    loadTextColorsFromStorage();
  }

  void loadTextColorsFromStorage()async{
    await storage.ready.then((e) {
      List<String> stringColors;
      if (storage.getItem("textColors") != null)
        stringColors = List<String>.from(storage.getItem("textColors"));

      if (stringColors == null || stringColors.length == 0) {
        List<Color> colorsList = <Color>[
          Colors.black,
          Colors.white,
        ];
        storage.setItem("textColors", MyColors.listHexFromColor(colorsList));
        setState(() {
          textColorsList = colorsList;
        });
      }else{
        setState(() {
          textColorsList = MyColors.listColorsFromListHex(stringColors);
        });
      }

    });
  }
  void loadColorsFromStorage() async{
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
        setState(() {
          colorList = colorsList;
        });
      }else{
        setState(() {
          colorList = MyColors.listColorsFromListHex(stringColors);
        });
      }

    });
  }

}
