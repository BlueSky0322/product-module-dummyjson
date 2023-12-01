import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_module/data/cart.dart';
import 'package:product_module/data/user.dart';
import 'package:product_module/services/cart_service.dart';
import 'package:provider/provider.dart';

class UserCartState extends ChangeNotifier {
  final BuildContext context;
  Cart? cart;
  late AuthedUser authedUser;
  final _cartService = CartService();
  bool isLoading = true;
  List<CartProduct> userCartItems = [];
  List<Cart> cartsList = [];

  UserCartState(this.context) {
    authedUser = Provider.of<AuthedUser>(context, listen: false);
    loadUserCart();
  }

  Future<void> loadUserCart() async {
    cartsList = await _cartService.getUserCart(authedUser.token, authedUser.id);
    userCartItems = cartsList[0].products!;
    isLoading = false;
    notifyListeners();
    if (!isLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Displaying cart of user ${authedUser.id}."),
          backgroundColor: Colors.green.shade300,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong ${authedUser.id}."),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
  }
}
