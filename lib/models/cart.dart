import 'package:fiboeda/models/catalog.dart';
import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> items = [];

  int get totalItems => items.length;
  int get totalPrice => items
      .map((e) => e.totalPrice)
      .reduce((value, element) => value + element);

  void add(Product item) {
    if (!items.any((element) => element.product == item)) {
      items.add(CartItem(item));
    }
    notifyListeners();
  }

  void remove(Product item) {
    items.removeWhere((element) => element.product == item);
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }

  bool inCart(Product item) {
    return items.any((element) => element.product == item);
  }
}

@immutable
class CartItem {
  final Product product;
  int qty;

  int get totalPrice => product.price * this.qty;

  CartItem(this.product)
      : qty = 1;
}
