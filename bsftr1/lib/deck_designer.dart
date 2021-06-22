import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

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
              Expanded(child:FileUploadWidget()),
              Expanded(child:makeField()),
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

class FileUploadWidget extends StatelessWidget {
  late DropzoneViewController _controller;
  String? _filename;

  void _handleFileDrop(dynamic ev) async {
    // ファイル情報を読み込む。
    //_filename = await _controller.getFilename(ev);
    //_fileSize = await _controller.getFileSize(ev);
    //_fileMIME = await _controller.getFileMIME(ev);
    //_fileData = await _controller.getFileData(ev);

    // 一時的なリンクを生成して表示する。
    final url = await _controller.createFileUrl(ev);
    print(url);
    _controller.releaseFileUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return DropzoneView(
      operation: DragOperation.move,
      cursor: CursorType.auto,
      //onCreated: (ctrl) => _controller = ctrl,
      onDrop: (ev) => _handleFileDrop(ev),
      //onError: (ev) => print('Error: $ev'),
      //onHover: () => setState(() {_hoverFlag = true;}),
      //onLeave: () => setState(() {_hoverFlag = false;}),
    );
  }
}
