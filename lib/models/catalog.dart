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

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        price = map['price'],
        image = map['image'],
        description = map['description'];

  Product.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data());
}

class CatalogModel {
  List<Map> _categories = [];
  List<Product> _products = [];

  UnmodifiableListView<Map> get categories => UnmodifiableListView(_categories);
  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  Future init() async {
    QuerySnapshot categories = await FirebaseFirestore.instance.collection('categories').get();
    _categories = categories.docs.map((e) => { e.id: e['title'] }).toList();

    QuerySnapshot products = await FirebaseFirestore.instance.collection('products').get();
    _products = products.docs.map((e) => Product.fromSnapshot(e)).toList();
  }
}