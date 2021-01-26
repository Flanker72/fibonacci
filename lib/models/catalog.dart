import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Catalog product model
@immutable
class Product {
  /// Product unique identifier (string ID from Firebase)
  final String id;

  /// Product name
  final String title;

  /// Link to image if exists
  final String image;

  /// Product description
  final String description;

  /// Price of one product
  final int price;

  /// Parent category (Reference in Firebase)
  final DocumentReference parent;

  /// Construct product with id and data
  Product.fromMap(this.id, Map<String, dynamic> data)
      : title = data['title'],
        price = data['price'],
        image = data['image'],
        description = data['description'],
        parent = data['parent'];

  /// Construct product with Firebase snapshot
  Product(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.id, snapshot.data());
}

/// Catalog category model
@immutable
class Category {
  /// Category unique identifier (string ID from Firebase)
  final String id;

  /// Category name
  final String title;

  /// Order in list
  final int order;

  /// Link to image if exists
  final String image;

  /// Construct category with Firebase snapshot
  Category(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.id, snapshot.data());

  /// Construct category with id and data
  Category.fromMap(this.id, Map<String, dynamic> data)
      : title = data['title'],
        order = data['order'],
        image = data['image'];
}

/// Catalog model: access to whole catalog
class CatalogModel {
  /// List of categories
  List<Category> categories = [];

  /// List of products
  List<Product> products = [];

  /// Fill catalog from Firebase. We don't need to observe changes in realtime,
  /// so data loading and parsing can be called on demand.
  Future init() async {
    // Read categories and create list of them
    QuerySnapshot _categories = await FirebaseFirestore.instance
        .collection('categories')
        .orderBy('order')
        .get();
    categories = _categories.docs.map((e) => Category(e)).toList();

    // Read products and create list of them
    QuerySnapshot _products =
        await FirebaseFirestore.instance.collection('products').get();
    products = _products.docs.map((e) => Product(e)).toList();
  }

  /// Filter products by given category
  List<Product> getProductsFromCategory(Category category) {
    return products
        .where((e) => e.parent != null ? e.parent.id == category.id : false)
        .toList();
  }
}
