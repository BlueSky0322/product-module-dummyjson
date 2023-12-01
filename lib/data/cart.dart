import 'package:flutter/cupertino.dart';

class Cart {
  int? id;
  List<CartProduct>? products;
  double? total;
  double? discountedTotal;
  int? userId;
  int? totalProducts;
  int? totalQuantity;

  Cart({
    this.id,
    this.products,
    this.total,
    this.discountedTotal,
    this.userId,
    this.totalProducts,
    this.totalQuantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<CartProduct> products = (json['products'] as List<dynamic>)
        .map((productJson) => CartProduct.fromJson(productJson))
        .toList();

    return Cart(
      id: json['id'],
      products: products,
      total: json['total'].toDouble(),
      discountedTotal: json['discountedTotal'].toDouble(),
      userId: json['userId'],
      totalProducts: json['totalProducts'],
      totalQuantity: json['totalQuantity'],
    );
  }
}

class CartProduct {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedPrice;
  final String thumbnail;

  CartProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.thumbnail,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      total: json['total'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      discountedPrice: json['discountedPrice'].toDouble(),
      thumbnail: json['thumbnail'],
    );
  }
}

class AddCartItemRequest {
  final bool merge = true;
  final List<CartItem> products;

  AddCartItemRequest({
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'merge': merge,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class CartItem {
  final int id;
  final int quantity;

  CartItem({
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}
