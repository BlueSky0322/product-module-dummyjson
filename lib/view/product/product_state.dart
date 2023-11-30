import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:product_module/data/product.dart';
import 'package:product_module/data/user.dart';
import 'package:product_module/services/product_service.dart';
import 'package:provider/provider.dart';

class ProductPageState extends ChangeNotifier {
  final BuildContext context;
  bool isFirstLoadRunning = false;
  final _productService = ProductService();
  late AuthedUser authedUser;
  List<ProductShort> productsList = [];

  int skip = 0;
  int limit = 10;

  ProductPageState(this.context) {
    // Initialize the UserProvider in the constructor
    authedUser = Provider.of<AuthedUser>(context, listen: false);
    // log("${authedUser.token}");
    firstLoad();
  }

  Future<void> firstLoad() async {
    isFirstLoadRunning = true;
    notifyListeners();

    productsList =
        await _productService.getProducts(authedUser.token, limit, skip);
    isFirstLoadRunning = false;
    notifyListeners();
  }
}
