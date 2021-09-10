import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_ui/models/itemModel.dart';

class ShopProvider with ChangeNotifier {
  late Map<String, Item> items;
  late String _tag;

  //Initializing the class
  ShopProvider() {
    items = {};
  }

  int get itemQuantCount {
    int count =0;
    items.values.forEach((item) => count+=item.itemQuantity);
    return count;
  }
  double get totalAmount {
    double amount =0;
    items.values.forEach((item) => amount+=item.cartPrice());
    return amount;
  }


  int get itemCount => items.values.length;

  // void addItem(Item item) {
  //   if(items.containsKey(item.itemId)){
  //
  //     items.update(item.itemId, (cartItem) => cartItem.copy(
  //         id: cartItem.itemId,
  //         title: cartItem.itemTitle,
  //         volume: cartItem.itemVolume,
  //         amount: cartItem.itemAmount,
  //         quantity: cartItem.itemQuantity + 1 ,
  //         description: cartItem.itemDescription,
  //         image: cartItem.itemImg));
  //   }
  //   else{
  //     items.putIfAbsent(item.itemId, () => item.copy(
  //         id: item.itemId,
  //         title: item.itemTitle,
  //         volume: item.itemVolume,
  //         amount: item.itemAmount,
  //         quantity: item.itemQuantity,
  //         description: item.itemDescription,
  //         image: item.itemImg));
  //         }
  //   // items[DateTime.now().toString()] = item;
  //   notifyListeners();
  // }

  void clearItems(Map items){
    items.clear();
    notifyListeners();
  }

  void clearItem(String key){
    items.remove(key);
    notifyListeners();
  }

  void addItem(Item item, int value) {
    if(items.containsKey(item.itemId)){

      items.update(item.itemId, (cartItem) => cartItem.copy(
          id: cartItem.itemId,
          title: cartItem.itemTitle,
          volume: cartItem.itemVolume,
          amount: cartItem.itemAmount,
          quantity: value,
          description: cartItem.itemDescription,
          image: cartItem.itemImg));
    }
    else{
      items.putIfAbsent(item.itemId, () => item.copy(
          id: item.itemId,
          title: item.itemTitle,
          volume: item.itemVolume,
          amount: item.itemAmount,
          quantity: value,
          description: item.itemDescription,
          image: item.itemImg));
    }
    // items[DateTime.now().toString()] = item;
    notifyListeners();
  }

set tag(String value){
  _tag = value;
  notifyListeners();
}
String get tag =>_tag;

}
