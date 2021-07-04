// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/Note.dart';
import 'package:flutter_app1/states/NoteWidgetState.dart';
import 'package:flutter_app1/widgets/NoteWidget.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:localstorage/localstorage.dart';

class NoteListInterfaceCategroy extends StatefulWidget {
  final String category;

  const NoteListInterfaceCategroy(this.category);

  @override
  _NoteListInterface createState() => _NoteListInterface(category);
}

class _NoteListInterface extends State<NoteListInterfaceCategroy> {
  List<GlobalKey<NoteWidgetState>> globalKeys = [];
  String category;
  bool _EDITOR = false;
  List<NoteWidget> _noteWidgets = <NoteWidget>[];
  int size = 0;

  final LocalStorage storage = new LocalStorage('notes');

  _NoteListInterface(this.category);

  void _addToNotes(NoteWidget note) {
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

  void _resetEditorMode() {
    setState(() {
      _EDITOR = false;
    });
  }

  deleteSelectedNotes() {
    List<GlobalKey<NoteWidgetState>> temp = [];

    List<Map<String, dynamic>> list =
        List<Map<String, dynamic>>.from(storage.getItem("list"));
    List<Note> notes =
        List<Note>.from(list.map((e) => new Note.fromJSON(e)).toList());

    for (NoteWidget note in _noteWidgets) {
      if (note.note.selected) {
        int index = notes.indexOf(note.note);
        list.removeAt(index);
        notes.removeAt(index);
      }
    }

    storage.setItem("list", list);

    loadStateFromStorage();

    clearList();
    resetList();

    /*List<GlobalKey<NoteWidgetState>> temp = [];
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

    setState(() {
      _EDITOR = false;
      globalKeys = temp;
      print(temp);
    });

    storage.setItem("list", noteList);
    loadStateFromStorage();

    clearList();
    resetList();*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Category: " + category),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
            itemCount: size,
            itemBuilder: (BuildContext bbContext, int index) {
              return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [displayNotewidget(_noteWidgets.elementAt(index))]);
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
    super.initState();
    loadStateFromStorage();
  }

  loadStateFromStorage() {
    _noteWidgets = <NoteWidget>[];
    List<Map<String, dynamic>> jsonList =
        List<Map<String, dynamic>>.from(storage.getItem("list"));

    if (jsonList == null || jsonList.length == 0) {
      /*jsonList = [];
      jsonList.add(Note.extras("NOTE TITLE", "THIS IS THE NOTE CONTENT ",
              DateTime.now(), Colors.black, Colors.blue, ["HELLO","TEST"])
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
              DateTime.now(), Colors.black, Colors.lightGreenAccent, ["HELLO"])
          .toJSON());
      storage.setItem("list", jsonList);*/
    } else {
      print("READ FROM JSON");
    }

    int i = 0;
    for (Map<String, dynamic> element in jsonList) {
      GlobalKey<NoteWidgetState> key = GlobalKey<NoteWidgetState>();
      globalKeys.add(key);
      Note note = Note.fromJSON(element);
      if (note.category.contains(category)) {
        _addToNotes(new NoteWidget(
          note: Note.fromJSON(element),
          position: i,
          EDITOR: _getEDITORVALUE,
          key: key,
          categoryItem: true,
        ));
        i++;
      }
    }
    setState(() {
      size = _noteWidgets.length;
    });
  }
}
