import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<FirebaseUser>(
    //     future: FirebaseAuth.instance.currentUser(),
    //     builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
    //       if (snapshot.hasData) {
    //         FirebaseUser user = snapshot.data; // this is your user instance
    //         /// is because there is user already logged
    return Home();
    //       }
    /// other way there is no user logged.
    // return Login();
    // });
  }
}
