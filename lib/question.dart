import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';import 'dart:math';
//TODO: Just deal with it later

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final firestoreInstance = Firestore.instance;
  bool nextQuestion = false;
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
                  String question;
                  String businessName;
                  String choiceOne;
                  String choiceTwo;
                  String documentId;
                  int randomValue;
                  int choiceOneCount;
                  int choiceTwoCount;

                  void getQuestions() {
                    randomValue = new Random().nextInt(snapshots.data.documents.length);
                    print(randomValue);
                    documentSnapshot = snapshots.data.documents[randomValue];
                    documentId = documentSnapshot.documentID;
                    question = documentSnapshot["Question"];
                    businessName = documentSnapshot["Business Name"];
                    choiceOne = documentSnapshot["Choice1"];
                    choiceTwo = documentSnapshot["Choice2"];
                    choiceOneCount = documentSnapshot["choiceOneCount"];
                    choiceTwoCount =documentSnapshot["choiceTwoCount"];
                  };

                  void addCounter(int choice){
                    DocumentReference documentReference = Firestore.instance.collection("Questions").document(documentId);
                    if (choice == 1){
                      int newValue = choiceOneCount + 1;
                      documentReference.updateData({"choiceOneCount": newValue});
                    }
                    else{
                      documentReference.updateData({"choiceTwoCount": choiceTwoCount + 1});
                    }
                    
                  }

                  if (snapshots.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          getQuestions();
                          return Column(
                            children: [
                              new Text(question),
                              new Text(businessName),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  new FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        addCounter(1);
                                        getQuestions();
                                      });
                                    },
                                    child: new Text(choiceOne),
                                  ),
                                  new FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        addCounter(2);
                                        getQuestions();
                                      });
                                    },
                                    child: new Text(choiceTwo),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
    );
  }
}
