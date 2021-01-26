import 'package:fiboeda/constants.dart';
import 'package:fiboeda/models/cart.dart';
import 'package:fiboeda/models/catalog.dart';
import 'package:fiboeda/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const route = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Корзина заказа'),
      ),
      body: cart.totalItems > 0 ? _Cart(cart: cart) : _EmptyCart(cart: cart),
    );
  }
}

class _Cart extends StatefulWidget {
  const _Cart({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final CartModel cart;

  @override
  __CartState createState() => __CartState();
}

class __CartState extends State<_Cart> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...widget.cart.items.map((e) => _cardListBuilder(context, e)).toList(),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Здесь пусто :(',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 20.0),
          Text('Ещё ничего не добавлено в заказ.'),
          SizedBox(height: 20.0),
          OutlineButton(
            borderSide:
                BorderSide(width: 2.0, color: Theme.of(context).primaryColor),
            highlightedBorderColor: Colors.white,
            child: Text('Открыть Фибо Меню'),
            onPressed: () {
              Navigator.of(context)
                  .popUntil((route) => route.settings.name == IndexPage.route);
            },
          ),
          SizedBox(height: 80.0),
          Image.asset('assets/logo_vertical.png'),
          SizedBox(height: 60.0),
        ],
      ),
    );
  }
}

Widget _cardListBuilder(BuildContext context, CartItem item) {
  final cart = Provider.of<CartModel>(context);

  return ListTile(
    isThreeLine: true,
    title: Text(
      '${item.product.title}',
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.fade,
    ),
    subtitle: item.product.description != null
        ? Text(
            '${item.product.description}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        : Text(''),
    trailing: Container(
        width: 120.0,
        child: SpinBox(
          min: 1,
          max: 99,
          value: item.qty.toDouble(),
          onChanged: (value) {
            item.qty = value.toInt();
          },
        )),
  );
}
