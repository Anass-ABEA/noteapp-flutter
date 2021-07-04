// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/Note.dart';
import 'package:flutter_app1/states/NoteWidgetState.dart';
import 'package:flutter_app1/widgets/NoteWidget.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:localstorage/localstorage.dart';

import '../main.dart';

class NoteListInterface extends StatefulWidget {
  @override
  _NoteListInterface createState() => _NoteListInterface();
}

class _NoteListInterface extends State<NoteListInterface> {
  List<GlobalKey<NoteWidgetState>> globalKeys = [];


  bool _EDITOR = false;
  List<NoteWidget> _noteWidgets = <NoteWidget>[];
  int size = 0;

  final LocalStorage storage = new LocalStorage('notes');

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
        size = _noteWidgets.length;
      });
    });
  }

  clearList() async {
    setState(() {
      size = 0;
    });
  }

  bool _getEDITORVALUE() {
    return _EDITOR;
  }

  deleteSelectedNotes() {
    List<GlobalKey<NoteWidgetState>> temp = [];
    int i = 0;
    List<Map<String, dynamic>> noteList = <Map<String, dynamic>>[];
    for (NoteWidget note in _noteWidgets) {
      print(note.note.selected);
      if (!note.note.selected) {
        note.note.selected = false;
        noteList.add(note.note.toJSON());
        temp.add(globalKeys[i]);
      }
      i++;
    }

    storage.setItem("list", noteList);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyApp(0)));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: _noteWidgets.length==0,
        child: FloatingActionButton.extended(onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp(1)));
        }, label: Text("New Note"),icon: Icon(Icons.add),),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("NOTES"),
      ),
      body: WillPopScope(

          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: ListView.builder(
                  itemCount: size,
                  itemBuilder: (BuildContext bbContext, int index) {
                    return Column(mainAxisSize: MainAxisSize.max, children: [
                      displayNotewidget(_noteWidgets.elementAt(index))
                    ]);
                  }),
            ),
            floatingActionButton: new Visibility(
                visible: _EDITOR,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    deleteSelectedNotes();
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  label: Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                  backgroundColor: Colors.white,
                )),
          ),
          onWillPop: () async {
            if (_EDITOR) {
              setState(() {
                _EDITOR = false;
              });
              clearList();
              resetList();
            } else {
              return true;
            }
            return false;
          }),
    );
  }

  ElevatedButton displayNotewidget(NoteWidget widget) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          print(globalKeys
              .elementAt(widget.position)
              .currentState
              .note
              .selected);
        },
        child: widget,
        onLongPress: () {
          setState(() {
            _EDITOR = true;
          });
          clearList();
          resetList();
        });
  }

  @override
  void initState() {
    loadStateFromStorage();
    super.initState();
  }

  loadStateFromStorage() async  {
    List<Map<String, dynamic>> jsonList;
    for( int i = 0; i< 3 ; i++){
      try{
        await storage.ready.then((value) => jsonList = List<Map<String, dynamic>>.from(storage.getItem("list")));
        print("STORAGE FULL "+jsonList.length.toString());
        break;
      }catch(e){
        jsonList = [];
        storage.setItem("list", []);
        sleep(Duration(milliseconds: 100));
      }
    }

   /* if (jsonList == null || jsonList.length == 0) {
      print("JSON LIST " +jsonList.toString());

      *//*jsonList = [];
      jsonList.add(Note.extras(
          "NOTE TITLE",
          "THIS IS THE NOTE CONTENT ",
          DateTime.now(),
          Colors.black,
          Colors.blue,
          ["TEST", "HELLO", "Test 2"]).toJSON());
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
      jsonList.add(Note.extras(
          "NOTE TITLE",
          "THIS IS THE NOTE CONTENT ",
          DateTime.now(),
          Colors.black,
          Colors.lightGreenAccent,
          ["HELLO"]).toJSON());

      List<String> categories = [];
      categories.add("TEST");
      categories.add("TEST 2");
      categories.add("HELLO");
      storage.setItem("categories", categories);

      storage.setItem("list", jsonList);*//*

    } else {
      print("READ FROM JSON");
    }*/

    int i = 0;
    print("AM IN!! "+jsonList.length.toString());
    List<NoteWidget> notesWDGT = [];
    for (Map<String, dynamic> element in jsonList) {
      GlobalKey<NoteWidgetState> key = GlobalKey<NoteWidgetState>();
      globalKeys.add(key);
      notesWDGT.add(new NoteWidget(
        note: Note.fromJSON(element),
        position: i,
        EDITOR: _getEDITORVALUE,
        key: key,
        categoryItem: false,
      ));

      setState(() {
        _noteWidgets = notesWDGT;
      });
      i++;
    }
    setState(() {
      size = _noteWidgets.length;
    });
  }
}
