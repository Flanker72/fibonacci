import 'package:badges/badges.dart';
import 'package:fiboeda/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBadge extends StatelessWidget {
  final Widget child;
  final BadgePosition position;

  CartBadge({Key key, this.position, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cart, child) {
      return Badge(
        badgeContent: Text('${cart.totalItems}'),
        showBadge: cart.totalItems > 0,
        badgeColor: Theme.of(context).primaryColor,
        child: this.child,
        position: this.position,
      );
    });
  }
}
