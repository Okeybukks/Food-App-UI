import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ui/provider/provider.dart';
import 'package:shop_ui/screens/products_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final state = ShopProvider();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return state;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
            primarySwatch: Colors.deepOrange,
            primaryColor: Colors.white,
            textTheme: TextTheme(
              bodyText2: TextStyle(color: Colors.white),
            )),
        home: ProductsPage(),
      ),
    );
  }
}


