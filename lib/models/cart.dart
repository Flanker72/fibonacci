import 'package:fiboeda/models/catalog.dart';
import 'package:flutter/foundation.dart';

/// Cart model: access to whole cart
class CartModel extends ChangeNotifier {
  /// List of items in cart
  final List<CartItem> items = [];

  /// Total items stored in cart
  int get totalItems => items.length;
  /// Total price of all cart items
  int get totalPrice => items
      .map((e) => e.totalPrice)
      .reduce((value, element) => value + element);

  /// Add product to cart with consumers notification
  void add(Product item) {
    if (!items.any((element) => element.product == item)) {
      items.add(CartItem(item));
    }
    notifyListeners();
  }

  /// Remove product from cart with consumers notification
  void remove(Product item) {
    items.removeWhere((element) => element.product == item);
    notifyListeners();
  }

  /// Clear cart and notify consumers
  void clear() {
    items.clear();
    notifyListeners();
  }

  /// Check if product is added to cart
  bool inCart(Product item) {
    return items.any((element) => element.product == item);
  }
}


///Cart Item model
class CartItem {
  /// Catalog product
  final Product product;
  /// Product quantity
  int qty;

  /// Total price getter: count sum for quantity
  int get totalPrice => product.price * this.qty;

  /// Constructor: create cart item from product with quantity of 1
  CartItem(this.product)
      : qty = 1;
}
