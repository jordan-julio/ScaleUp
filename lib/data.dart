import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO: I am thinking of adding google authenticator so we can work with it easily, for the adding and checking data
//There should be something from firebase to help with the google thing

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
              if (snapshots.hasData) {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshots.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshots.data.documents[index];
                        int total = documentSnapshot["choiceOneCount"] +
                            documentSnapshot["choiceTwoCount"];
                        int choiceOnePercentage =
                            (documentSnapshot["choiceOneCount"] / total * 100)
                                .round();
                        int choiceTwoPercentage = 100 - choiceOnePercentage;
                        return Container(
                          child: Column(
                            children: [
                              Text(documentSnapshot["Question"]),
                              Text(documentSnapshot["Business Name"]),
                              Row(
                                children: [
                                  Text(documentSnapshot["Choice1"]),
                                  Text(choiceOnePercentage.toString())
                                ],
                              ),
                              Row(
                                children: [
                                  Text(documentSnapshot["Choice2"]),
                                  Text(choiceTwoPercentage.toString())
                                ],
                              ),
                            ],
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
