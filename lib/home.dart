import 'package:flutter/material.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import 'add.dart';
import 'data.dart';
import 'question.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: new Icon(Icons.assessment, color: Colors.white),
      title: new Text('Data', style: TextStyle(color: Colors.white)),
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.question_answer, color: Colors.white),
      title: new Text('Question', style: TextStyle(color: Colors.white)),
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.add_box, color: Colors.white),
      title: new Text('Add', style: TextStyle(color: Colors.white)),
    ),
  ];

  final List<Widget> _children = [Data(), Question(), Add()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'This or That',
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[400],
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: items[_currentIndex].title,
          ),
          body: DoubleBackToCloseApp(
            child: _children[_currentIndex],
            snackBar: SnackBar(
              content: Text('Tap Back Again To Exit App'),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey[850],
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: items,
          ),
        ),
      ),
    );
  }
}
