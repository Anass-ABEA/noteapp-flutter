// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_app1/interfaces/NewNoteInterface.dart';
import 'package:flutter_app1/interfaces/NoteListInterface.dart';
import 'package:flutter_app1/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOTES',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'NOTES'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;

  void _onPageSelected(int pos) {
    setState(() {
      _selectedPage = pos;
    });
  }

  List<Widget> _pages = [
    NoteListInterface(),
    NewNoteInterface(note: null),
    Center(
      child: Text("OK 2"),
    ),
    Settings(),
  ];

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
            icon: Icon(Icons.category_outlined, size: 30),
            label: 'Categories',
            backgroundColor: Colors.blue,
            activeIcon: Icon(Icons.category, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, size: 30),
            label: 'Settings',
            backgroundColor: Colors.blue,
            activeIcon: Icon(Icons.settings, size: 30),
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
