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
        _Form()
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
            cart.setQty(item, value.toInt());
          },
        )),
  );
}


class _Form extends StatefulWidget {
  const _Form();

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Center(
                child: Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return Text(
                      'Итого ${cart.totalPrice}₽',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                ),
              ),
              SizedBox(height: 16.0),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                minLeadingWidth: 20.0,
                title: TextField(
                  decoration: InputDecoration(hintText: 'Ваше имя'),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Theme.of(context).primaryColor,
                ),
                minLeadingWidth: 20.0,
                title: TextField(
                  decoration: InputDecoration(hintText: 'Номер телефона'),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.people,
                  color: Theme.of(context).primaryColor,
                ),
                minLeadingWidth: 20.0,
                title: TextField(
                  decoration: InputDecoration(hintText: 'Количество персон'),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                ),
                minLeadingWidth: 20.0,
                title: TextField(
                  decoration: InputDecoration(hintText: 'Дата и время'),
                ),
              ),
              SizedBox(height: 32.0),
              Center(
                child: Text('Мы перезвоним для уточнения деталей.',
                    style: TextStyle(color: Colors.grey)),
              ),
              Divider(height: 48.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: OutlineButton(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Оформить',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  borderSide: BorderSide(
                      width: 2.0, color: Theme.of(context).primaryColor),
                  highlightedBorderColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).popUntil(
                            (route) => route.settings.name == IndexPage.route);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}