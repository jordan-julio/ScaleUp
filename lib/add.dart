import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO: Just put like textfields and let them input

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final firestoreInstance = Firestore.instance;
  final businessName = TextEditingController();
  final questions = TextEditingController();
  final choice1 = TextEditingController();
  final choice2 = TextEditingController();
  final busName = "Business Name";
  final qContext = "Question";
  final c1 = "Choice1";
  final c2 = "Choice2";
  final c1count = "choiceOneCount";
  final c2count = "choiceTwoCount";

  @override
  void dispose() {
    businessName.dispose();
    questions.dispose();
    choice1.dispose();
    choice2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
        child: new Column(
          children: <Widget>[
            new TextField(
                controller: businessName,
                decoration: new InputDecoration(
                    labelText: "Business Name",
                    floatingLabelBehavior: FloatingLabelBehavior.auto)),
            new Text(""),
            new TextField(
                controller: questions,
                decoration: new InputDecoration(
                    labelText: "Question",
                    floatingLabelBehavior: FloatingLabelBehavior.auto)),
            new Text(""),
            new TextField(
                controller: choice1,
                decoration: new InputDecoration(
                    labelText: "Choice 1",
                    floatingLabelBehavior: FloatingLabelBehavior.auto)),
            new Text(""),
            new TextField(
                controller: choice2,
                decoration: new InputDecoration(
                    labelText: "Choice 2",
                    floatingLabelBehavior: FloatingLabelBehavior.auto)),
            new Text(""),
            FlatButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.blue, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(50)),
              color: Colors.teal[300],
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.teal[200],
              onPressed: () {
                firestoreInstance.collection("Questions").add({
                  busName: businessName.text,
                  qContext: questions.text,
                  c1: choice1.text,
                  c2: choice2.text,
                  c1count:0,
                  c2count:0 
                });
                businessName.clear();
                questions.clear();
                choice1.clear();
                choice2.clear();
              },
              child: Text(
                "Add",
              ),
            )
          ],
        ),
      ),
    );
  }
}
