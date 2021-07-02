import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/Note.dart';
import 'package:flutter_app1/widgets/NoteWidget.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:localstorage/localstorage.dart';

class NoteListInterfaceAll extends StatefulWidget {
  @override
  _NoteListInterface createState() => _NoteListInterface();
}

class MyBooleans{
  List<bool> list;
  MyBooleans(this.list);

  void update(int index, bool val) {
    list[index] = val;
  }
  clone(){
    return new MyBooleans(list);
  }
}
class _NoteListInterface extends State<NoteListInterfaceAll> {
  late MyBooleans selectedNotesListState;

  late List<Note> selectedState;

  bool _EDITOR = false;
  List<ElevatedButton> _noteWidgets = <ElevatedButton>[];
  int size = 0;

  final LocalStorage storage = new LocalStorage('notes');

  bool isEtditorOn() {
    return _EDITOR;
  }

  void _addToNotes(ElevatedButton note) {
    setState(() {
      _noteWidgets.add(note);
    });
  }

  changeDisplayEditor() {
    print("LONG PRESSED");
    setState(() {
      _EDITOR = true;
      size = 0;
      print("part1");
      sleep(Duration(seconds: 1));
      size = _noteWidgets.length;
      print("part2");
    });
  }

  Future<void> resetList() {
    return Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        initializeList();
      });
    });
  }

  refreshList(){
    List<ElevatedButton> temp = [..._noteWidgets];
    clearList();

    Future.delayed(const Duration(milliseconds: 10),(){
      setState(() {
        _noteWidgets = [...temp];
        size = _noteWidgets.length;
      });
    });
  }

  clearList() async {
    setState(() {
      size = 0;
      _noteWidgets = <ElevatedButton>[];
    });
  }

  void _resetEditorMode() {
    setState(() {
      _EDITOR = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
          itemCount: size,
          itemBuilder: (BuildContext bbContext, int index) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [_noteWidgets.elementAt(index)],
            );
          }),
    );
  }

  ElevatedButton displayNotewidget(Container widget, int index) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          if (_EDITOR) {
            changeStateTo(index, !selectedNotesListState.list[index]);
          }
        },
        child: widget,
        onLongPress: () {
          setState(() {
            _EDITOR = true;
          });
          print("long press");
          clearList();
          resetList();
        });
  }

  @override
  void initState() {
    super.initState();
    initializeList();
  }

  changeStateTo(int index, bool val) {
    setState(() {
      /*selectedNotesListState.update(index,val);
      selectedNotesListState = selectedNotesListState.clone();*/
      selectedState.elementAt(index).selected = val;
      selectedState = selectedState.toList();
      print(selectedState.elementAt(index).selected);
    });
  }

  initializeList() {
    List<Map<String, dynamic>> jsonList =
        List<Map<String, dynamic>>.from(storage.getItem("list"));

    if (jsonList == null) {
      jsonList = [];
      jsonList.add(Note.extras("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.blue, "HELLO")
          .toJSON());
      jsonList.add(Note("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.orangeAccent)
          .toJSON());
      jsonList.add(Note("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.yellowAccent)
          .toJSON());
      jsonList.add(Note("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.lightGreenAccent)
          .toJSON());
      jsonList.add(Note("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.blue)
          .toJSON());
      jsonList.add(Note("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.orangeAccent)
          .toJSON());
      jsonList.add(Note("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.yellowAccent)
          .toJSON());
      jsonList.add(Note("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.lightGreenAccent)
          .toJSON());
      jsonList.add(Note("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.blue)
          .toJSON());
      jsonList.add(Note("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.orangeAccent)
          .toJSON());
      jsonList.add(Note("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.yellowAccent)
          .toJSON());
      jsonList.add(Note.extras("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.lightGreenAccent, "HELLO")
          .toJSON());

      storage.setItem("list", jsonList);
      print(jsonList.length);
    }
    selectedNotesListState =  MyBooleans(<bool>[]);
    selectedState = <Note>[];
    int i = 0;
    for (Map<String, dynamic> element in jsonList) {
      selectedNotesListState.list.add(false);
      Note note = Note.fromJSON(element);
      selectedState.add(note);
      _addToNotes(displayNotewidget(
          Container(
            color: note.bgColor,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.white, width: 2))),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: getTitleAndCategory(i, note, _EDITOR),
                              ),
                            ),
                          ))),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      note.content,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "RobotoSlab",
                        color: note.textColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          i));
      i++;
    }

    size = _noteWidgets.length;
  }

  getTitleAndCategory(int index, Note note, bool edit) {
    List<Widget> res = [];
    List<Widget> children = [];

    if (_EDITOR) {
      children.add(Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.red,
        value: selectedState.toList().elementAt(index).selected,
        onChanged: (bool? val) {
          print("CHANGE IN STATE " + val.toString());
          changeStateTo(index, val!);
        },
      ));
    }

    children.add(Text(
      note.title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: note.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 17,
          fontFamily: "RobotoSlab"),
    ));
    res.add(Row(
      children: children,
    ));
    if (note.category.length > 0) {
      res.add(FlatButton(
          onPressed: () {
            print(_EDITOR);
          },
          onLongPress: () {},
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white, width: 2)),
            child: Text(
              note.category,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: note.bgColor,
                  fontFamily: "RobotoSlab"),
            ),
          )));
    }
    return res;
  }


}

class OneNote extends StatefulWidget{
  @override
  OneNoteState createState() => OneNoteState();
}

class OneNoteState extends State<OneNote>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
