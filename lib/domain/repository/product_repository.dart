import 'dart:convert';

import 'package:codeme_task/domain/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  static Future<List<ProductModel>> fetchProducts() async {
    final url = Uri.parse('https://fakestoreapi.com/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
