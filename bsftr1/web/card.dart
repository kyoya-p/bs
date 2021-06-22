class Item {
  int left;
  int top;

  Item({required int this.left, required int this.top});

  static from(dynamic o) => Item(left: o["left"] as int, top: o["left"] as int);
}

class Card extends Item {
  String imgUrlBack;
  String imgUrlFace1 = "";
  String imgUrlFace2 = "";

  Card(Item item, {required String this.imgUrlBack})
      : super(left: item.left, top: item.top);

  static from(dynamic o) =>
      Card(Item.from(o), imgUrlBack: o["imgUrlBack"] as String);

  toObject() => {"left": left, "top": top, "imgUrlBack": imgUrlBack};

}
