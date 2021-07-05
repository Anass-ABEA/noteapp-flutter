// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/Note.dart';
import 'package:flutter_app1/states/NoteWidgetState.dart';

// ignore: must_be_immutable
class NoteWidget extends StatefulWidget {
  @override
  NoteWidgetState createState() => NoteWidgetState(note:note,position:position,editor:editor,categoryItem: categoryItem);

   final Note note;
   final int position;
   bool categoryItem;

  NoteWidget({Key key, @required this.position, @required this.note, @required this.editor,  @required this.categoryItem})
      : super(key: key);

   bool Function() editor;
}
