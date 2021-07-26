import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/providers/cart.dart';
import 'package:shop_provider/providers/orders.dart';
import 'package:shop_provider/providers/products.dart';
import 'package:shop_provider/screens/cart_screen.dart';
import 'package:shop_provider/screens/edit_product_screen.dart';
import 'package:shop_provider/screens/orders_screen.dart';
import 'package:shop_provider/screens/product_detail_screen.dart';
import 'package:shop_provider/screens/products_overview_screen.dart';
import 'package:shop_provider/screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Something',
        theme: ThemeData(
            primarySwatch: Colors.pink, accentColor: Colors.greenAccent),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
          CartScreen.routeName: (_) => CartScreen(),
          OrdersScreen.routeName: (_) => OrdersScreen(),
          UserProductsScreen.routeName: (_) => UserProductsScreen(),
          EditProductScreen.routeName: (_) => EditProductScreen(),
        },
      ),
    );
  }
}
