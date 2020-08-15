import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final firestoreInstance = Firestore.instance;
  bool questionsObtained = false;
  String question;
  String businessName;
  String choiceOne;
  String choiceTwo;
  String documentId;

  int randomValue;
  int choiceOneCount;
  int choiceTwoCount;
  @override
  void init() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
        child: new Column(
          children: <Widget>[
            StreamBuilder(
                stream: firestoreInstance.collection("Questions").snapshots(),
                builder: (context, snapshots) {
                  DocumentSnapshot documentSnapshot;

                  void getQuestions() {
                    if (!questionsObtained) {
                      randomValue =
                          new Random().nextInt(snapshots.data.documents.length);
                      print(randomValue);
                      documentSnapshot = snapshots.data.documents[randomValue];
                      documentId = documentSnapshot.documentID;
                      question = documentSnapshot["Question"];
                      businessName = documentSnapshot["Business Name"];
                      choiceOne = documentSnapshot["Choice1"];
                      choiceTwo = documentSnapshot["Choice2"];
                      choiceOneCount = documentSnapshot["choiceOneCount"];
                      choiceTwoCount = documentSnapshot["choiceTwoCount"];
                      questionsObtained = true;
                    }
                  }

                  getQuestions();

                  void addCounter(int choice) {
                    DocumentReference documentReference = Firestore.instance
                        .collection("Questions")
                        .document(documentId);
                    if (choice == 1) {
                      documentReference
                          .updateData({"choiceOneCount": choiceOneCount + 1});
                    } else {
                      documentReference
                          .updateData({"choiceTwoCount": choiceTwoCount + 1});
                    }
                  }

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              new Text(
                                question,
                                style: TextStyle(fontSize: 26),
                              ),
                              Container(height: 50),
                              new Text(
                                businessName,
                                style: TextStyle(fontSize: 16),
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  new FlatButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        addCounter(1);
                                        questionsObtained = false;
                                      });
                                    },
                                    child: new Text(choiceOne),
                                  ),
                                  Container(
                                    width: 50,
                                  ),
                                  new FlatButton(
                                    color: Colors.green,
                                    onPressed: () {
                                      setState(() {
                                        addCounter(2);
                                        questionsObtained = false;
                                      });
                                    },
                                    child: new Text(choiceTwo),
                                  ),
                                  Container(
                                    height: 200,
                                    width: 1,
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
