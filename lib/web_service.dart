import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final int productId;
  final String sku;
  final double minPrice;
  final double maxPrice;
  final int stockQuantity;

  Product({
    required this.productId,
    required this.sku,
    required this.minPrice,
    required this.maxPrice,
    required this.stockQuantity,
  });

  // Factory method to create a Product from JSON data
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      sku: json['sku'],
      minPrice: json['min_price'],
      maxPrice: json['max_price'],
      stockQuantity: json['stock_quantity'],
    );
  }
}

class WebService {
  //static const String apiUrl = 'http://52.195.7.18:8080/api/products';
  static const String apiUrl = 'https://d31vivxo65zd44.cloudfront.net/api/products';
  // Fetch all products from the API
  Future<List<Product>> fetchProducts() async {
    // print("Sending request to $apiUrl");
    // final response = await http.get(Uri.parse(apiUrl));

    // if (response.statusCode == 200) {
    //   print("Response received: ${response.body}");
    //   List<dynamic> body = jsonDecode(response.body);
    //   List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
    //   return products;
    // } else {
    //   print("Failed to load products: ${response.statusCode}");
    //   throw Exception('Failed to load products');
    // }
    try {
      print("Sending request to $apiUrl");
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print("Response received: ${response.body}");
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Product.fromJson(item)).toList();
      } else {
        print("Failed to load products: ${response.statusCode}");
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Error occurred: $e");
      rethrow;
    }
  }
}