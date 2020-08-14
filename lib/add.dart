import 'package:flutter/material.dart';

//TODO: Just put like textfields and let them input

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
        child: new Column(
          children: <Widget>[
            new TextField(
                decoration: new InputDecoration(
                    labelText: "Business Name",
                    floatingLabelBehavior: FloatingLabelBehavior.auto)),
            new Text(""),
            new TextField(
                decoration: new InputDecoration(
                    labelText: "Question",
                    floatingLabelBehavior: FloatingLabelBehavior.auto)),
            new Text(""),
            new TextField(
                decoration: new InputDecoration(
                    labelText: "Choice 1",
                    floatingLabelBehavior: FloatingLabelBehavior.auto)),
            new Text(""),
            new TextField(
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
                /*...*/
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
