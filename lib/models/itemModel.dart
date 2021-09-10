import 'package:meta/meta_meta.dart';

class Item {
  final String itemImg, itemTitle, itemDescription, itemId;
  final int itemQuantity, itemVolume;
  final double itemAmount;


  const Item(
      {required this.itemVolume,
      required this.itemId,
      required this.itemDescription,
      required this.itemImg,
      required this.itemTitle,
      required this.itemQuantity,
      required this.itemAmount});

  Item copy(
      {required String id,
      required String title,
      required String description,
      required String image,
      required int quantity,
      required int volume,
      required double amount}) {
    return Item(
        itemId: id,
        itemQuantity: quantity,
        itemDescription: description,
        itemVolume: volume,
        itemAmount: amount,
        itemImg: image,
        itemTitle: title);
  }

  double cartPrice(){
    return (itemQuantity * itemAmount);
  }
}
