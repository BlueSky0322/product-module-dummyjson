import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_module/data/product.dart';
import 'package:product_module/data/user.dart';
import 'package:product_module/services/product_service.dart';
import 'package:product_module/utils/price_sorting.dart';
import 'package:provider/provider.dart';

class ProductPageState extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  final BuildContext context;
  late ScrollController controller;
  final _productService = ProductService();
  late AuthedUser authedUser;
  List<ProductShort> tempProductsList = [];
  List<ProductShort> productsList = [];
  List<ProductShort> fetchedProducts = [];
  List<String> categories = [];
  List<String> selectedCategories = [];
  int skip = 0;
  int limit = 10;
  bool isFirstLoadRunning = false;
  bool hasNextPage = true;
  bool isLoadMoreRunning = false;
  bool enableBacktToTop = false;
  final ValueNotifier<bool> selected = ValueNotifier<bool>(false);

  PriceSorting? selectedSorting;

  ProductPageState(this.context) {
    // Initialize the UserProvider in the constructor
    authedUser = Provider.of<AuthedUser>(context, listen: false);
    // log("${authedUser.token}");
    firstLoad();
    getCategories();
    controller = ScrollController()
      ..addListener(() {
        loadMore();
        isAtEnd();
      });
  }

  Future<void> getCategories() async {
    categories = await _productService.getProductCategories(authedUser.token);
    for (var element in categories) {
      log("${element}\n");
    }
  }

  Future<void> firstLoad() async {
    skip = 0;
    isFirstLoadRunning = true;
    notifyListeners();

    productsList =
        await _productService.getProducts(authedUser.token, limit, skip);
    tempProductsList = productsList;
    isFirstLoadRunning = false;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Displaying first 10 items."),
        backgroundColor: Colors.green.shade300,
      ),
    );
  }

  Future<void> loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        controller.position.extentAfter < 100) {
      isLoadMoreRunning = true;
      notifyListeners();

      skip += 10;

      fetchedProducts =
          await _productService.getProducts(authedUser.token, limit, skip);

      if (fetchedProducts.isNotEmpty) {
        productsList.addAll(fetchedProducts);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Displaying first ${skip + 10} items."),
            backgroundColor: Colors.green.shade300,
          ),
        );
        tempProductsList = productsList;
      } else {
        hasNextPage = false;
        enableBacktToTop = true;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All content displayed.'),
            backgroundColor: Colors.amber,
          ),
        );
      }

      isLoadMoreRunning = false;
      notifyListeners();
    }
  }

  Future<void> backToTop() async {
    await controller.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> isAtEnd() async {
    final isEnd = controller.offset >= controller.position.maxScrollExtent;
    if (!isEnd && controller.offset >= 200) {
      enableBacktToTop = true;
      notifyListeners();
    } else {
      enableBacktToTop = false;
      notifyListeners();
    }
  }

  void clearControllers() {
    searchController.text = "";
    restoreList();
    notifyListeners();
  }

  void searchProduct(String query) {
    final suggestions = productsList.where((product) {
      final productTitle = product.title.toLowerCase();
      final input = query.toLowerCase();
      return input.isEmpty || productTitle.contains(input);
    }).toList();

    productsList = suggestions;
    notifyListeners();
  }

  void restoreList() {
    productsList = tempProductsList;
    notifyListeners();
  }

  void enableChip(String item) {
    selected.value = !selected.value;
    selectedCategories.add(item);
    // filterProduct();
    notifyListeners();
  }

  void disableChip(String item) {
    selected.value = !selected.value;
    selectedCategories.remove(item);
    if (selectedCategories.isEmpty && selected.value == false) {
      restoreList();
    }
    notifyListeners();
  }

  void enablePriceChip() {
    selected.value = !selected.value;
    // filterProduct();
    notifyListeners();
  }

  void sortProductsByPrice() {
    if (selectedSorting == PriceSorting.lowToHigh) {
      productsList.sort((a, b) => a.price.compareTo(b.price));
    } else if (selectedSorting == PriceSorting.highToLow) {
      productsList.sort((a, b) => b.price.compareTo(a.price));
    }

    notifyListeners();
  }
}
