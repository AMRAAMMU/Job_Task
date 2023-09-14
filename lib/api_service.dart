import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_task/product_model.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['products'];
      final List<Product> productList = jsonList.map((json) => Product.fromJson(json)).toList();
      return productList;
    } else {
      throw Exception('Failed to load products');
    }
  }
}

