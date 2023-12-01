import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:product_module/data/cart.dart';
import 'package:product_module/utils/const.dart';

class CartService {
  final client = Client();
  Future<List<Cart>> getUserCart(String? token, int? userId) async {
    // final url = Uri.parse(
    //     '$baseUrl/auth/products?limit=$limit&skip=$skip&select=title,price');
    var url = Uri.parse('$baseUrl/auth/carts/user/$userId');

    try {
      final response = await client.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);
        List<dynamic> cartsData = responseData['carts'];
        List<Cart> carts =
            cartsData.map((data) => Cart.fromJson(data)).toList();

        // for (var element in carts) {
        //   log("${element.id};");
        //   for (var x in element.products) {
        //     log("${x.title};");
        //   }
        // }
        return carts;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      log('Error retrieving object in: $error');
      return [];
    }
  }

  Future<Cart?> updateCart(
      String? token, int? cartId, AddCartItemRequest addCartItemRequest) async {
    // final url = Uri.parse(
    //     '$baseUrl/auth/products?limit=$limit&skip=$skip&select=title,price');
    var url = Uri.parse('$baseUrl/auth/carts/$cartId');
    final jsonData = json.encode(addCartItemRequest.toJson());

    try {
      final response = await client.put(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);
        Cart cart = Cart.fromJson(responseData);

        return cart;
      } else {
        log('API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error retrieving object in: $error');
    }
    return null;
  }
}
