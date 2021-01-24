import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:fiboeda/constants.dart';
import 'package:fiboeda/models/cart.dart';
import 'package:fiboeda/models/catalog.dart';
import 'package:fiboeda/pages/cart.dart';
import 'package:fiboeda/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          Consumer<CartModel>(builder: (context, cart, child) {
            return Badge(
              badgeContent: Text('${cart.totalItems}'),
              showBadge: cart.totalItems > 0,
              badgeColor: Theme.of(context).primaryColor,
              position: BadgePosition.topEnd(top: 3, end: 3),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartPage.route);
                },
              ),
            );
          }),
        ],
      ),
      drawer: FiboDrawer(),
      backgroundColor: kFiboBlack,
      body: _bodyBuilder(context),
    );
  }
}

Widget _bodyBuilder(BuildContext context) {
  final catalog = Provider.of<CatalogModel>(context);
  List<Widget> widgets = [];

  catalog.categories.forEach((category) {
    final List<Product> products = catalog.getProductsFromCategory(category);

    if (products.isNotEmpty) {
      if (category.image != null && category.image.isNotEmpty) {
        widgets.add(Image.network(category.image));
      }
      widgets.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                category.title,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
      widgets.add(GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        shrinkWrap: true,
        primary: false,
        childAspectRatio: 0.6,
        semanticChildCount: products.length,
        children: products.map((data) => _cardBuilder(context, data)).toList(),
      ));
    }
  });

  return ListView(
    children: widgets,
  );
}

Widget _cardBuilder(BuildContext context, Product product) {
  final cart = Provider.of<CartModel>(context);

  return Card(
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    color: Colors.grey[900],
    elevation: 3.0,
    child: Column(
      children: [
        Card(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
          elevation: 0.0,
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: product.image != null && product.image != ''
                ? Image.network(product.image)
                : Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Image.asset('assets/logo_vertical.png'),
                  ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Center(
              child: AutoSizeText(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
                minFontSize: 10,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FlatButton(
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.symmetric(vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                color:
                    cart.inCart(product) ? Colors.grey[600] : Colors.grey[800],
                onPressed: () {
                  if (cart.inCart(product)) {
                    cart.remove(product);
                  } else {
                    cart.add(product);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      cart.inCart(product)
                          ? Icons.check
                          : Icons.add_shopping_cart,
                      size: 18.0,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      '${product.price}₽',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

