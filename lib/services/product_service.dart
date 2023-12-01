import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:product_module/utils/const.dart';
import 'package:product_module/data/product.dart';

class ProductService {
  final client = Client();
  Future<List<ProductShort>> getProducts(
      String? token, int limit, int skip) async {
    // final url = Uri.parse(
    //     '$baseUrl/auth/products?limit=$limit&skip=$skip&select=title,price');
    var url = Uri.parse('$baseUrl/auth/products');

    var params = {
      'limit': limit.toString(),
      'skip': skip.toString(),
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
          log("${element.id};");
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

  Future<Product?> getSingleProduct(String? token, int? id) async {
    // final url = Uri.parse(
    //     '$baseUrl/auth/products?limit=$limit&skip=$skip&select=title,price');
    var url = Uri.parse('$baseUrl/auth/products/$id');

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
        Product product = Product.fromJson(responseData);

        return product;
      } else {
        log('API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error retrieving object in: $error');
    }
    return null;
  }

  Future<List<String>> getProductCategories(String? token) async {
    final url = Uri.parse('$baseUrl/auth/products/categories');

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
        List<String> categories = responseData.cast<String>();
        return categories;
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
