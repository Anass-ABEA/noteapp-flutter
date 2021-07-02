import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/Note.dart';
import 'package:flutter_app1/widgets/NoteWidget.dart';

class _NoteWidget extends State<NoteWidget> {
  late final Note note;

  _NoteWidget(this.note, this.position, this._EDITOR);

  bool Function() _EDITOR;
  int position;
  bool _isSelected = false;
  late bool _isEdit ;

  toggleState(){
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  static changeState(){

  }

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
        activeColor: Colors.red,
        value: _isSelected,
        onChanged: (bool? val) {
          setState(() {
            _isSelected = val!;
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
    if (note.category.length > 0) {
      res.add(FlatButton(
          onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            bottom: BorderSide(color: Colors.white, width: 2))),
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
    );
  }

  @override
  void initState() {
    this._isEdit = Function.apply(_EDITOR, null);
  }
}