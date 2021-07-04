// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/Note.dart';
import 'package:flutter_app1/interfaces/NewNoteInterface.dart';
import 'package:flutter_app1/interfaces/NoteListInterfaceCategroy.dart';
import 'package:flutter_app1/widgets/NoteWidget.dart';

import '../main.dart';

class NoteWidgetState extends State<NoteWidget> {
  final Note note;

  bool categoryItem;

  NoteWidgetState({@required this.note, @required this.position, @required this.EDITOR, @required this.categoryItem});

  bool Function() EDITOR;
  int position;
  bool _isSelected = false;
   bool _isEdit;

  toggleState() {
    setState(() {
      _isSelected = !_isSelected;
      note.selected = _isSelected;
    });
  }

  static changeState() {}

  _changeCheckState() {
    setState(() {
      _isSelected = true;
    });
  }

  getTitleAndCategory() {
    List<Widget> res = [];
    List<Widget> children = [];

    if (_isEdit) {
      children.add(Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.redAccent,
        value: _isSelected,
        onChanged: (bool val) {
          setState(() {
            _isSelected = val;
            note.selected = _isSelected;
          });
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
    if (note.category.isNotEmpty) {
      res.add(
        Row(
          children: [
            Text("Categories",style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 0, 0, 0.5)),textAlign: TextAlign.left),
            Container(
              height: 50,
              width: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: note.category.length,
                itemBuilder: (BuildContext bc, int index){
                  String e = note.category[index];
                  return FlatButton(
                      onPressed: () {
                        if(!categoryItem)
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteListInterfaceCategroy(e)));
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
                              fontSize: 17,
                              color: note.bgColor,
                              fontFamily: "RobotoSlab"),
                        ),
                      ));
                },
              ),
            )
          ],
        )

      );
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        if (Function.apply(EDITOR, null)) {
          print("EDITOR MODE ON");
          setState(() {
            _isSelected = !_isSelected;
            note.selected = _isSelected;
          });
        } else {
          print("EDITOR MODE off");
          Navigator.push(context,MaterialPageRoute(builder: (context)=>NewNoteInterface(note: note,pos: position,)));
        }
      },
      child: Container(
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
    );
  }

  @override
  void initState() {
    print(categoryItem);
    this._isEdit = Function.apply(EDITOR, null);
  }


}
