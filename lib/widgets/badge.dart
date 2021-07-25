import 'package:flutter/material.dart';
import 'package:shop_provider/screens/cart_screen.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key? key,
    this.value,
    this.color,
  }) : super(key: key);

  final String? value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.of(context).pushNamed(CartScreen.routeName);
        },
      ),
      Positioned(
        left: 8,
        top: 8,
        child: Container(
          padding: EdgeInsets.all(2.0),
          // color: Theme.of(context).accentColor,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: color != null ? color : Theme.of(context).accentColor,
          ),
          constraints: BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
          child: Text(
            value!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      )
    ]);
  }
}
