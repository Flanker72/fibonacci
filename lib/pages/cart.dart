import 'package:fiboeda/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const route = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Корзина заказа'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 90.0),
            Text(
              'Сумма заказа',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 30.0),
            Text(
              '${cart.totalPrice} руб.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
