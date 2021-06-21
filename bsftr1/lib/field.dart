import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

Widget makeField() {
  var items = db.collection("bs");
  return StreamBuilder<QuerySnapshot>(
    stream: items.snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> s) {
      List<Widget> cards = s.data?.docs
              .map((e) => makeItem(e.data() as Map<String, dynamic>))
              .toList() ??
          [];
      return DragTarget(
        builder: (context, candidateData, rejectedData) => Container(
          color: Colors.blue[100],
          child: Expanded(
              child: Stack(
            children: cards,
          )),
        ),
      );
    },
  );
}

Widget makeItem(Map<String, dynamic> e) {
  double top = e["top"] as double;
  double left = e["left"] as double;
  String url = e["url_back"] as String;

  return Positioned(
    top: top,
    left: left,
    child: Draggable(
      child: Container(
        height: 20,
        width: 20,
        color: Colors.black,
      ),
      feedback: Container(
        height: 20,
        width: 20,
        color: Colors.black12,
      ),
    ),
  );
}

Widget streamBuilder<T>(
    {required List<Stream<T>> streams,
    required AsyncWidgetBuilder<T> builder}) {
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
