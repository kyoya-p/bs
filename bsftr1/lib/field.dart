import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
/*
Widget makeField() {
  var c = db.collection("user/${user.uid}/app1");
  return StreamBuilder<>(
    builder: (context, accepted, rejected) {
      return Container(
        width: 200,
        height: 200,
        color: Colors.grey,
        child: Stack(
          children:,
        ),
      );
    },
  );
}

 */

Widget streamBuilder<T>(
    {required List<Stream<T>> streams, required AsyncWidgetBuilder<
        T> builder}) {
  return StreamBuilder<T>(
    stream: streams[0],
    builder: builder,
  );
}

Widget makeItemTest() {
  return Draggable(
    data: 'Green',
    child: Container(
      width: 100,
      height: 100,
      color: Colors.green,
    ),
    feedback: Container(
      width: 100,
      height: 100,
      color: Colors.green.withOpacity(0.5),
    ),
    childWhenDragging: Container(
      width: 100,
      height: 100,
      color: Colors.green,
    ),
  );
}
