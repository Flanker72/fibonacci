import 'package:fiboeda/models/catalog.dart';
import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  int get totalItems => _items.length;
  int get totalPrice => _items
      .map((e) => e.totalPrice)
      .reduce((value, element) => value + element);

  void add(Product item) {
    if (!_items.any((element) => element.product == item)) {
      _items.add(CartItem(item));
    }
    notifyListeners();
  }

  void remove(Product item) {
    _items.removeWhere((element) => element.product == item);
    notifyListeners();
  }
}

@immutable
class CartItem {
  final Product product;
  final int qty;

  int get totalPrice => product.price * this.qty;

  CartItem(this.product) : qty = 1;
}
