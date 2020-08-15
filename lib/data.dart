import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  final firestoreInstance = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream: firestoreInstance.collection("Questions").snapshots(),
            builder: (context, snapshots) {
              if(snapshots.data == null) return CircularProgressIndicator();
              else if (snapshots.hasData) {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshots.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshots.data.documents[index];
                        int choiceOnePercentage;
                        int choiceTwoPercentage;
                        int total = documentSnapshot["choiceOneCount"] +
                            documentSnapshot["choiceTwoCount"];
                        if (total == 0) {
                          choiceOnePercentage = 0;
                          choiceTwoPercentage = 0;
                        } else {
                          choiceOnePercentage =
                              (documentSnapshot["choiceOneCount"] / total * 100)
                                  .round();
                          choiceTwoPercentage = 100 - choiceOnePercentage;
                        }
                        return Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    documentSnapshot["Question"],
                                    style: TextStyle(fontSize: 26),
                                  ),
                                  Text(
                                    documentSnapshot["Business Name"],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Container(height: 30,),
                                  Row(
                                    children: [
                                      Text(documentSnapshot["Choice1"],
                                          style: TextStyle(fontSize: 16)),
                                      Container(width: 25,),
                                      Text("$choiceOnePercentage %",
                                          style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                  Container(height: 25,),
                                  Row(
                                    children: [
                                      Text(documentSnapshot["Choice2"],
                                          style: TextStyle(fontSize: 16)),
                                      Container(width: 25,),
                                      Text("$choiceTwoPercentage %",
                                          style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                  Container(height: 50,),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return Column(
                  children: [CircularProgressIndicator(), Text('Loading')],
                );
              }
            })
      ],
    );
  }
}
