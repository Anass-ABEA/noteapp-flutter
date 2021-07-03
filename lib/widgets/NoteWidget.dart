// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/Note.dart';
import 'package:flutter_app1/states/NoteWidgetState.dart';

class NoteWidget extends StatefulWidget {
  @override
  NoteWidgetState createState() => NoteWidgetState(note:note,position:position,EDITOR:EDITOR,categoryItem: categoryItem);

   final Note note;
   final int position;
   bool categoryItem;

  NoteWidget({Key key, @required this.position, @required this.note, @required this.EDITOR,  @required this.categoryItem})
      : super(key: key);

   bool Function() EDITOR;
}
