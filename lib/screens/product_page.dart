import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ui/data/products.dart';
import 'package:shop_ui/data/tag.dart';
import 'package:shop_ui/provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int value = 1;

  @override
  Widget build(BuildContext context) {
    ShopProvider provider = Provider.of<ShopProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFBF7F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            provider.tag = Tags.imageUrl(products[widget.index].itemImg);
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.3,
              child: Center(
                  child: Hero(
                      tag: provider.tag,
                      child: Image.asset(products[widget.index].itemImg))),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Text(
              '${products[widget.index].itemTitle}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.035,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              '${products[widget.index].itemVolume}ml',
              style: TextStyle(
                  color: Colors.black26,
                  fontSize: height * 0.02,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                quantityWidget(height, width),
                Text(
                  '\$${products[widget.index].itemAmount}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: height * 0.035,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.035,
            ),
            Text(
              'About the Product',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.032,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text('${products[widget.index].itemDescription} ',
                style: TextStyle(color: Colors.black, fontSize: 17)),
            SizedBox(
              height: height * 0.025,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    provider.tag = Tags.cartImageUrl(products[widget.index].itemImg);
                    provider.addItem(products[widget.index], value);
                    print(value);
                    Navigator.pop(context);

                  },
                  child: Text('Add to Cart', style: TextStyle(fontSize: height * 0.03),),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(width * 0.5, height * 0.07),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
            )
          ],
        ),
      ),
    );
  }

  Container quantityWidget(double height, double width) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: IconButton(
                  onPressed: () {
                    if (value == 1) {
                      setState(() {
                        value = value;
                      });
                    } else {
                      setState(() {
                        value -= 1;
                      });
                    }
                  },
                  icon: Icon(Icons.remove))),
          Expanded(
              child: Center(
                  child: Text(
            '$value',
            style: TextStyle(color: Colors.black, fontSize: 22),
          ))),
          Expanded(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      value += 1;
                    });
                  },
                  icon: Icon(Icons.add)))
        ],
      ),
      height: height * 0.07,
      width: width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.black26,
            width: 1,
          )),
    );
  }
}
