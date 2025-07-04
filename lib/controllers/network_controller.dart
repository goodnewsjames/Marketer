import 'dart:convert';
import 'package:http/http.dart' as http; // Use alias for clarity
import 'package:marketer/models/product.dart';

class NetworkController {
  Future<List<Product>> fetchData() async {
    final url = Uri.parse("https://fakestoreapi.com/products");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception("HTTP request failed with status: ${response.statusCode}");
    }
  }
}