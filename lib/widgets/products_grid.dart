import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/providers/product.dart';
import 'package:shop_provider/providers/products.dart';
import 'package:shop_provider/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavs ? productsData.favoritesItems : productsData.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
          //create: (ctx) => products[index],
        );
      },
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
    );
  }
}
