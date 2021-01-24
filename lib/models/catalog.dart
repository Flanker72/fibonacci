import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Product {
  final String id;
  final String title;
  final String image;
  final String description;
  final int price;
  final DocumentReference parent;

  Product.fromMap(this.id, Map<String, dynamic> data)
      : title = data['title'],
        price = data['price'],
        image = data['image'],
        description = data['description'],
        parent = data['parent'];

  Product(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.id, snapshot.data());
}

@immutable
class Category {
  final String id;
  final String title;
  final int order;
  final String image;
  Category(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.id, snapshot.data());

  Category.fromMap(this.id, Map<String, dynamic> data)
      : title = data['title'],
        order = data['order'],
        image = data['image'];
}

class CatalogModel {
  List<Category> categories = [];
  List<Product> products = [];

  // UnmodifiableListView<Category> get categories =>
  //     UnmodifiableListView(_categories);
  // UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  Future init() async {
    QuerySnapshot _categories = await FirebaseFirestore.instance
        .collection('categories')
        .orderBy('order')
        .get();
    categories = _categories.docs.map((e) => Category(e)).toList();
    QuerySnapshot _products =
        await FirebaseFirestore.instance.collection('products').get();
    products = _products.docs.map((e) => Product(e)).toList();
  }

  List<Product> getProductsFromCategory(Category category) {
    return products
        .where((e) => e.parent != null ? e.parent.id == category.id : false)
        .toList();
  }
}
