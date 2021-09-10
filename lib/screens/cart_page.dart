import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ui/models/itemModel.dart';
import 'package:shop_ui/provider/provider.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    ShopProvider provider = Provider.of<ShopProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.105,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  'Cart',
                  style:
                      TextStyle(color: Colors.white, fontSize: height * 0.04),
                ),
                TextButton(
                    onPressed: () {
                      myAlert(context).then((value) {
                        if (value == true) {
                          setState(() {
                            provider.clearItems(provider.items);
                          });
                        }
                      });
                    },
                    child: Text('Clear Cart',
                        style: TextStyle(
                            color: Colors.white, fontSize: height * 0.02)))
              ],
            ),
            Expanded(child: buildItemCards(context)),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  'Total:',
                  style:
                      TextStyle(color: Colors.white, fontSize: height * 0.02),
                ),
                Text('\$ ${provider.totalAmount}',
                    style:
                        TextStyle(color: Colors.white, fontSize: height * 0.03))
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Next',
                style: TextStyle(fontSize: height * 0.03),
              ),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(width, height * 0.07),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemCards(BuildContext context) {
    ShopProvider provider = Provider.of<ShopProvider>(
      context,
    );
    return provider.items.isNotEmpty
        ? ListView(
            children: provider.items.values
                .map((e) => buildItemCard(context, e))
                .toList())
        : Center(
            child: Text('Cart is Empty'),
          );
  }

  Widget buildItemCard(BuildContext context, Item item) {
    ShopProvider provider = Provider.of<ShopProvider>(
      context,
    );
    return Dismissible(
      key: Key(item.itemId),
      onDismissed: (direction) {
        provider.clearItem('${item.itemId}');
      },
      background: Container(
        height: 150,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.delete, color: Colors.white),
              Text('Delete from Cart', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('${item.itemImg}'),
        ),
        title: Row(
          children: [
            Text('${item.itemQuantity}x',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
                  '${item.itemTitle}',
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ),
        trailing: Text('\$ ${item.cartPrice()}'),
      ),
    );
    //   Slidable(
    //   actionPane: SlidableDrawerActionPane(),
    //   // closeOnScroll: false,
    //   secondaryActions: <Widget>[
    //     Container(
    //       child: IconButton(
    //         onPressed: (){
    //           setState(() {
    //             provider.clearItem('${item.itemId}');
    //           });
    //         },
    //         icon: Icon(Icons.delete),
    //         color: Colors.white,
    //       ),
    //       height: 40,
    //       width: 40,
    //       decoration:
    //       BoxDecoration(color: Colors.deepOrange, shape: BoxShape.circle),
    //     ),
    //   ],
    //   child: ListTile(
    //     leading: CircleAvatar(
    //       backgroundColor: Colors.white,
    //       backgroundImage: AssetImage('${item.itemImg}'),
    //     ),
    //     title: Row(
    //       children: [
    //         Text('${item.itemQuantity}x',
    //             style: TextStyle(color: Colors.white, fontSize: 18)),
    //         SizedBox(
    //           width: 10,
    //         ),
    //         Expanded(
    //             child: Text(
    //               '${item.itemTitle}',
    //               style: TextStyle(color: Colors.white),
    //               maxLines: 1,
    //               overflow: TextOverflow.ellipsis,
    //             )),
    //       ],
    //     ),
    //     trailing: Text('\$ ${item.cartPrice()}'),
    //   ),
    // );


  }
}

Future<dynamic> myAlert(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Do you wish to clear cart?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      'No',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ));
}
