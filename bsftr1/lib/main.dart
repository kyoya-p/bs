import 'package:bsftr/deck_designer.dart';
import 'package:flutter/material.dart';

import 'field.dart';
import 'login.dart';

void main() {
//  runApp(MyApp());
  runApp(FirebaseSignInWidget(appBuilder: (context, snapshot) => MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeckDesigner(),
    );
  }
}