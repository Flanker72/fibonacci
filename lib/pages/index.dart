import 'package:badges/badges.dart';
import 'package:fiboeda/constants.dart';
import 'package:fiboeda/models/cart.dart';
import 'package:fiboeda/models/catalog.dart';
import 'package:fiboeda/widgets/cart_badge.dart';
import 'package:fiboeda/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  static const route = '/';

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppTitle),
        actions: [
          CartBadge(
            position: BadgePosition.topEnd(top: 3, end: 3),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
            ),
          ),
        ],
      ),
      drawer: FiboDrawer(),
      body: _bodyBuilder(context),
    );
  }
}

Widget _bodyBuilder(BuildContext context) {
  final catalog = Provider.of<CatalogModel>(context);
  return ListView(
    children: catalog.products.map((data) => _cardBuilder(context, data)).toList(),
  );
}

Widget _cardBuilder(BuildContext context, Product product) {
  return ListTile(
    leading: AspectRatio(
      aspectRatio: 1.0,
      child: Image.network(product.image),
    ),
    isThreeLine: true,
    title: Text(
      product.title,
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.fade,
    ),
    subtitle: Text(
      product.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: OutlineButton(
      color: kFiboRed,
      onPressed: () {
        final cart = context.read<CartModel>();
        cart.add(product);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_shopping_cart,
            size: 14.0,
          ),
          SizedBox(width: 2.0),
          Text('${product.price}₽')
        ],
      ),
    ),
  );
}
