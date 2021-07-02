import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/Note.dart';
import 'package:flutter_app1/states/NoteWidgetState.dart';

class NoteWidget extends StatefulWidget {
  @override
  NoteWidgetState createState() => NoteWidgetState(note, position, EDITOR);

  late final Note note;
  late final int position;

  NoteWidget({Key? key, required this.position, required this.note, required this.EDITOR})
      : super(key: key);

  late bool Function() EDITOR;
}
