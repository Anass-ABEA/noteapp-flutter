// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/classes/Note.dart';
import 'package:flutter_app1/interfaces/NewNoteInterface.dart';

class NewNoteState extends State<NewNoteInterface> {
  Note note;

  NewNoteState(Note note) {
    if (note == null) {
      this.note = new Note.empty();
    } else {
      this.note = note;
    }
  }

  setNoteTitle(String title) {
    setState(() {
      this.note.title = title;
    });
  }

  setNoteContent(String content) {
    setState(() {
      this.note.content = content;
    });
  }

  setColor(Color color) {
    setState(() {
      this.note.bgColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
        actions: [
          ElevatedButton(
              onPressed: () {},
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(2000)),
                child: Icon(
                  Icons.palette,
                  color: Colors.white,
                  size: 30,
                ),
              )),
          ElevatedButton(
              onPressed: () {},
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(2000)),
                child: Icon(
                  Icons.check,
                  color: Colors.greenAccent,
                  size: 30,
                ),
              ))
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(150, 150, 150, 0.8),
                blurRadius: 8,
                spreadRadius: 4)
          ],
          borderRadius: BorderRadius.circular(10),
          color: note.bgColor,
        ),
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Flex(
            direction: Axis.vertical,
            children: [
              TextFormField(
                onChanged: setNoteTitle,
                decoration: const InputDecoration(
                    hintText: 'Note title (optional)', labelText: "Note Title"),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: TextFormField(
                    onChanged: setNoteContent,
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: 'Note Body',
                        labelText: "Note Body",
                        alignLabelWithHint: true,
                        hintStyle: TextStyle(height: 1.2))),
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        child: Text(""),
                        onPressed: () {
                          setColor(Colors.blue);
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                      ),

                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        setColor(Colors.green);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                    ),

                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        setColor(Colors.yellowAccent);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellowAccent)),
                    ),

                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        setColor(Colors.blue);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                    ),

                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        setColor(Colors.green);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                    ),

                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        setColor(Colors.yellowAccent);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellowAccent)),
                    ),

                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        setColor(Colors.blue);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                    ),

                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        setColor(Colors.green);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                    ),

                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        setColor(Colors.yellowAccent);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellowAccent)),
                    ),

                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        setColor(Colors.blue);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                    ),

                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        setColor(Colors.green);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                    ),

                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(""),
                      onPressed: () {
                        setColor(Colors.yellowAccent);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellowAccent)),
                    ),

                  ),
                ],
              ),
              Visibility(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Text Color"),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(note.textColor)),
                            child: Container(
                              color: Colors.black,
                            )),
                        Text("Background Color"),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(note.bgColor)),
                            child: Container(
                              color: Colors.black,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Preview"),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          color: note.bgColor,
                          child: Text(
                            "ABC",
                            style:
                                TextStyle(color: note.textColor, fontSize: 20),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                visible: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
