import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:product_module/const.dart';
import 'package:product_module/data/product.dart';

class ProductService {
  final client = Client();
  Future<List<ProductShort>> getProducts(
      String? token, int limit, int skip) async {
    // final url = Uri.parse(
    //     '$baseUrl/auth/products?limit=$limit&skip=$skip&select=title,price');
    var url = Uri.parse('$baseUrl/auth/products');

    var params = {
      'limit': '10',
      'skip': '0',
      'select': 'title,price,rating,stock,category,thumbnail',
    };

    // Add query parameters to the URL
    var uri = Uri.https(url.authority, url.path, params);

    try {
      final response = await client.get(
        uri,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);
        List<ProductShort> products = (responseData['products'] as List)
            .map((data) => ProductShort.fromJson(data))
            .toList();
        for (var element in products) {
          log("${element.title};");
        }
        return products;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      log('Error retrieving object in: $error');
      return [];
    }
  }
}
