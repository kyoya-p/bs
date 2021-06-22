class Item {
  String? id;
  int left;
  int top;

  Item({this.id = null, required this.left, required this.top});

  static atOrNull(Map<String, dynamic> map, String key) =>
      map.entries.firstWhere((e) => e.key == key, orElse: null).value;

  static from(Map<String, dynamic> o) => Item(
      id: atOrNull(o, "id") as String?,
      left: atOrNull(o, "left") as int,
      top: atOrNull(o, "top") as int);
}

class Card extends Item {
  String imgUrlBack;
  String imgUrlFace1 = "";
  String imgUrlFace2 = "";

  Card(Item item, {required String this.imgUrlBack})
      : super(left: item.left, top: item.top);

  static from(dynamic o) =>
      Card(Item.from(o), imgUrlBack: o["imgUrlBack"] as String);

  toObject() => {"id": id, "left": left, "top": top, "imgUrlBack": imgUrlBack};
}
