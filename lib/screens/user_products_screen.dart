import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/providers/products.dart';
import 'package:shop_provider/screens/edit_product_screen.dart';
import 'package:shop_provider/widgets/app_drawer.dart';
import 'package:shop_provider/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemBuilder: (_, index) => Column(
                  children: [
                    UserProductItem(
                        title: productsData.items[index].title,
                        imageUrl: productsData.items[index].imageUrl),
                    Divider(),
                  ],
                ),
            itemCount: productsData.items.length),
      ),
    );
  }
}
