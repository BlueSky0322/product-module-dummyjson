import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_module/data/cart.dart';
import 'package:product_module/data/product.dart';
import 'package:product_module/data/user.dart';
import 'package:product_module/services/cart_service.dart';
import 'package:product_module/services/product_service.dart';
import 'package:provider/provider.dart';

class ProductDetailsState extends ChangeNotifier {
  final BuildContext context;
  late AuthedUser authedUser;
  // late Cart cart;
  final _productService = ProductService();
  final _cartService = CartService();
  bool isLoading = true;
  List<String> imgList = [];
  late int quantity;
  late int productId;
  Product? product;
  Cart? updatedCart;

  ProductDetailsState(this.context, this.productId) {
    authedUser = Provider.of<AuthedUser>(context, listen: false);
    // cart = Provider.of<Cart>(context, listen: false);
    quantity = 1;
    getSingleProduct();
  }

  Future<void> getSingleProduct() async {
    product =
        await _productService.getSingleProduct(authedUser.token, productId);

    if (product != null) {
      log(product!.description);
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Displaying ${product!.title} details."),
          backgroundColor: Colors.green.shade300,
        ),
      );
    }
  }

  Future<bool> addToCart() async {
    CartItem newCartItem = CartItem(
      id: productId,
      quantity: quantity,
    );

    AddCartItemRequest addCartItemRequest =
        AddCartItemRequest(products: [newCartItem]);
    updatedCart =
        await _cartService.updateCart(authedUser.token, 15, addCartItemRequest);

    if (updatedCart != null) {
      return true;
    } else {
      return false;
    }
  }
}
