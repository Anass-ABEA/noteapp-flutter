/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:localstorage/localstorage.dart';

class NotesList extends StatefulWidget {
  @override
  _NoteListState createState() => new _NoteListState();
}

class _NoteListState extends State<NotesList> {
  List<MyNote> myNotes = <MyNote>[];
  List<Note> noteWidget = <Note>[];
  bool _EDITOR = false;

  void changeEDITORMODE() {
    setState(() {
      _EDITOR = true;
    });
  }

  bool getEDITORMODE() {
    return _EDITOR;
  }

  final LocalStorage storage = new LocalStorage('notes');

  @override
  void initState() {
    super.initState();

    List<Map<String, dynamic>> jsonList = storage.getItem("list");

    if (jsonList != null)
      for (Map<String, dynamic> note in jsonList) {
        myNotes.add(new MyNote.fromJSON(note, changeEDITORMODE, _EDITOR));
      }
    else {
      myNotes.add(new MyNote.constructor(
          "note title",
          "note body. This is a note example",
          new DateTime(2021, 10, 10),
          Colors.black,
          Colors.blue,
          changeEDITORMODE,
          _EDITOR));
      myNotes.add(new MyNote.constructor(
          "note title",
          "note body. This is a note example",
          new DateTime(2021, 10, 10),
          Colors.black,
          Colors.orangeAccent,
          changeEDITORMODE,
          _EDITOR));
      myNotes.add(new MyNote.constructor(
          "note title",
          "note body. This is a note example",
          new DateTime(2021, 10, 10),
          Colors.yellow,
          Colors.blueAccent,
          changeEDITORMODE,
          _EDITOR));
      myNotes.add(new MyNote.constructor(
          "note title",
          "note body. This is a note example",
          new DateTime(2021, 10, 10),
          Colors.black,
          Colors.deepOrangeAccent,
          changeEDITORMODE,
          _EDITOR));
      myNotes.add(new MyNote.constructor(
          "note title",
          "note body. This is a note example",
          new DateTime(2021, 10, 10),
          Colors.black,
          Colors.lightGreenAccent,
          changeEDITORMODE,
          _EDITOR));
      myNotes.add(new MyNote.constructor(
          "note title",
          "note body. This is a note example",
          new DateTime(2021, 10, 10),
          Colors.black,
          Colors.deepOrangeAccent,
          changeEDITORMODE,
          _EDITOR));
      myNotes.add(new MyNote.constructor(
          "note title",
          "note body. This is a note example",
          new DateTime(2021, 10, 10),
          Colors.black,
          Colors.lightGreenAccent,
          changeEDITORMODE,
          _EDITOR));
      myNotes.add(new MyNote.constructor(
          "note title",
          "note body. This is a note example",
          new DateTime(2021, 10, 10),
          Colors.black,
          Colors.deepOrangeAccent,
          changeEDITORMODE,
          _EDITOR));
      myNotes.add(new MyNote.constructor(
          "note title",
          "note body. This is a note example",
          new DateTime(2021, 10, 10),
          Colors.black,
          Colors.lightGreenAccent,
          changeEDITORMODE,
          _EDITOR));
    }

    // INITIALIZE LOCAL STORAGE REMOVE LATER
    if (jsonList == null) {
      jsonList = [];
      for (MyNote note in myNotes) {
        jsonList.add(note.toJSON());
      }
      storage.setItem("list", jsonList);
    } else {
      print("JSON LENGTH IS " + jsonList.length.toString());
      print("VALUE HIDDEN IS " + jsonList.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
          itemCount: myNotes.length,
          itemBuilder: (BuildContext bbContext, int index) {
            return Column(
                mainAxisSize: MainAxisSize.max,
                children: [myNotes.elementAt(index).getRow(index)]);
          }),
    );
  }
}

class Note extends StatefulWidget {
  @override
  _Note createState() => new _Note();
}


class _Note extends State<Note> {
  late MyNote note;

  _changeCheckState(bool state) {
    setState(() {
      note.checked = state;
    });
  }

  Note(MyNote myNote) {
    this.note = myNote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text(note.title), Text(note.content)],
      ),
      backgroundColor: note.bgColor,
    );
  }
}

class MyNote {
  late bool checked = false;
  late String title;
  late String content;
  late DateTime date;
  late Color textColor;
  late Color bgColor;
  late String category = "";

  final VoidCallback changeState;
  final bool STATE;

  MyNote.fromJSON(Map<String, dynamic> json, this.changeState, this.STATE) {
    this.title = json["title"];
    this.content = json["content"];
    this.date = DateTime.parse(json["date"]);
    this.textColor = json["textColor"];
    this.bgColor = json["bgColor"];
    this.category = json["category"];
  }

  MyNote.constructor(String title, String content, DateTime date,
      Color textColor, Color bgColor, this.changeState, this.STATE) {
    this.title = title;
    this.content = content;
    this.date = date;
    this.textColor = textColor;
    this.bgColor = bgColor;
  }

  MyNote(String title, String content, DateTime date, this.changeState,
      this.STATE) {
    this.title = title;
    this.date = date;
    this.content = content;
    this.bgColor = Colors.blue;
    this.textColor = Colors.black;
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> res = new Map<String, dynamic>();
    res.putIfAbsent("title", () => title);
    res.putIfAbsent("date", () => date.toString());
    res.putIfAbsent("content", () => content);
    res.putIfAbsent("bgColor", () => bgColor);
    res.putIfAbsent("category", () => category);
    return res;
  }

  List<Widget> getTitleAndCategory() {
    List<Widget> res = [];

    if (!STATE) {
      res.add(
          Checkbox(
            value: checked,
            onChanged: _changeCheckState,

          )
      );
    }
    res.add(Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          fontFamily: "RobotoSlab"),
    ));

    if (category.length > 0) {
      res.add(FlatButton(
          onPressed: () {},
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white, width: 2)),
            child: Text(
              category,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: bgColor,
                  fontFamily: "RobotoSlab"),
            ),
          )));
    }
    return res;
  }

  _myMethod(int pos) {
    checked = true;
    print("LONG PRESSED " + pos.toString());
    return changeState;
  }

  Container getRow(int pos) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: bgColor,
        onPressed: () {
          print("pressed" + pos.toString());
        },
        onLongPress: () {
          return _myMethod(pos);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                              BorderSide(color: Colors.white, width: 2))),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: getTitleAndCategory(),
                          ),
                        ),
                      ))),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  content,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: "RobotoSlab"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

* */