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
      icon: new Icon(
        Icons.account_circle,
      ),
      title: new Text(
        'Profile',
      ),
    ),
    BottomNavigationBarItem(
      icon: new Icon(
        Icons.question_answer,
      ),
      title: new Text(
        'Question',
      ),
    ),
    BottomNavigationBarItem(
      icon: new Icon(
        Icons.add_box,
      ),
      title: new Text(
        'Add',
      ),
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
          appBar: AppBar(
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
            //TODO: change colour
            backgroundColor: Colors.teal[700],
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: items,
          ),
        ),
      ),
    );
  }
}
