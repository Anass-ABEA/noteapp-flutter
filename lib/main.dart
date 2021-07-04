// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_app1/interfaces/CategoryListInterface.dart';
import 'package:flutter_app1/interfaces/NewNoteInterface.dart';
import 'package:flutter_app1/interfaces/NoteListInterface.dart';

import 'interfaces/SettingsInterface.dart';

void main() {
  runApp(MyApp(0));
}

class MyApp extends StatelessWidget {
  final int page;

  MyApp(this.page);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOTES',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'NOTES',page: page,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title, this.page}) : super(key: key);
  final int page;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(this.page);
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage ;

  _MyHomePageState(this._selectedPage);

  void _onPageSelected(int pos) {
    setState(() {
      _selectedPage = pos;
    });
  }

  List<Widget> _pages = [
    NoteListInterface(),
    NewNoteInterface(note: null, pos:-1),
    SettngsInterface(),
  ];

 /* List<Widget> _pages = [
    NoteListInterface(),
    NewNoteInterface(note: null, pos:-1),
    CategoryListInterface(),
    SettngsInterface(),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: 'Home',
            backgroundColor: Colors.blue,
            activeIcon: Icon(Icons.home, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined, size: 30),
            label: 'Add',
            backgroundColor: Colors.blue,
            activeIcon: Icon(Icons.add, size: 30),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.palette_outlined, size: 30),
            label: 'Colors',
            backgroundColor: Colors.blue,
            activeIcon: Icon(Icons.palette, size: 30),
          )
        ],
        currentIndex: _selectedPage,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _onPageSelected,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
