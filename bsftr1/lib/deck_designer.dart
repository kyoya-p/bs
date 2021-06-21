
import 'package:flutter/material.dart';

import 'field.dart';

class DeckDesigner extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Deck Designer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: makeField()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createCard(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

createCard(BuildContext context) {
  TextEditingController imgUrl = TextEditingController();
  addCard() => db.collection("bs").add({"url": imgUrl.text});
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Create Card"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "Image URL"),
              controller: imgUrl,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => addCard(),
          child: Text("Add"),
        ),
      ],
    ),
  );
}
