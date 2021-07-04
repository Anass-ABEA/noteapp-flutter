// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/classes/Note.dart';
import 'package:flutter_app1/states/NewNoteState.dart';

class NewNoteInterface extends StatefulWidget{
  Note note;
  int pos;
  NewNoteInterface({Key key, note : Note,pos:int}): super(key: key){
    this.note = note;
    this.pos = pos;
  }


  @override
  NewNoteState createState() => NewNoteState(note,pos);


}