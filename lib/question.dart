import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//TODO: Just deal with it later

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final firestoreInstance = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Center(
            child: new Column(children: <Widget>[
      firestoreInstance.collection("Questions").get().then((value) {
        print(value.data);
      })
    ])));
  }
}
