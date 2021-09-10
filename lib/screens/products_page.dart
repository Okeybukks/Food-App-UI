import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ui/data/products.dart';
import 'package:shop_ui/data/tag.dart';
import 'package:shop_ui/models/itemModel.dart';
import 'package:shop_ui/provider/provider.dart';
import 'package:shop_ui/screens/cart_page.dart';
import 'package:shop_ui/screens/product_page.dart';
import 'package:shop_ui/transitions/custom_transition.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBF7F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Shop UI -Drinks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.filter_list))],
      ),
      body: SlidingUpPanel(
        // minHeight: 100,
        parallaxEnabled: true,
        parallaxOffset: 1,
        panelBuilder: (context) => CartPage(),
        body: Container(
            margin: EdgeInsets.only(bottom: 180),
            child: Stack(children: [
              productsWidget(),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 30,
                child: ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.black,
                  ),
                ),
              ),
            ])),
        collapsed: CartHeaderWidget(),
      ),
    );
  }

  Widget productsWidget() {
    return GridView(
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 3 / 4,
          crossAxisCount: 2),
      children: products
          .asMap()
          .entries
          .map((entry) => productContainer(entry.value, entry.key))
          .toList(),
    );
  }

  Widget productContainer(Item product, int index) =>
      GestureDetector(
        onTap: () {
          ShopProvider provider = Provider.of<ShopProvider>(context, listen: false);
          provider.tag = Tags.imageUrl(product.itemImg);
          Navigator.push(
              context,
              CustomPageRoute(ProductPage(
                index: index,
              )));
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Center(
                      child: Hero(
                          tag: Tags.imageUrl(product.itemImg),
                          child: Image.asset(product.itemImg)))),
              SizedBox(
                height: 10,
              ),
              Text(
                '\$ ${product.itemAmount}',
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${product.itemTitle}',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${product.itemVolume}ml',
                style:
                TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      );
}

class CartHeaderWidget extends StatelessWidget {
  const CartHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopProvider provider = Provider.of<ShopProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            'Cart',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: provider.items.values
                        .map((item) =>
                        Row(
                          children: [
                            Hero(
                              tag: Tags.cartImageUrl(item.itemImg),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(item.itemImg),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ))
                        .toList(),
                  ))),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.deepOrange,
            child: Text(
              // provider.itemCount
              '${provider.itemQuantCount}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double radius = 50.0;
    path.quadraticBezierTo(0, size.height, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
