class Item {
  int x;
  int y;

  Item({required int this.x, required int this.y});

  static from(dynamic o) => Item(x: o["x"] as int, y: o["y"] as int);
}

class Card extends Item {
  String imgUrlBack;
  String imgUrlFace1 = "";
  String imgUrlFace2 = "";

  Card(Item item, {required String this.imgUrlBack})
      : super(x: item.x, y: item.y);

  static from(dynamic o) =>
      Card(Item.from(o), imgUrlBack: o["imgUrlBack"] as String);

  toObject() => {
        "item": {"x": x, "y": y},
        "card": {"imgUrlBack": imgUrlBack}
      };
}
