import 'dart:convert';
import 'package:check/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _allProducts = [];
  bool _isLoading = false;

 

  // For products by category
  List<Product> _categoryProducts = [];
  bool _isCategoryProductsLoading = false;
  // GETTERS
  bool get isLoading => _isLoading;
  bool get isCategoryProductsLoading => _isCategoryProductsLoading;
  List<Product> get allProducts => _allProducts;
  List<Product> get categoryProducts => _categoryProducts;

  // FETCH ALL PRODUCTS
  Future<void> fetchAllProducts() async {
    try {
      _isLoading = true;
      final url = Uri.parse('https://dummyjson.com/products?limit=10');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> productsJson = data['products'] ?? [];
        _allProducts = productsJson.map((p) => Product.fromJson(p)).toList();
      }
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // FILTERED PRODUCTS (SEARCH)
  List<Product> filteredProducts(String query) {
    if (query.isEmpty) {
      return _allProducts;
    }
    return _allProducts
        .where((p) =>
            p.title.toLowerCase().contains(query.toLowerCase()) ||
            p.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }



  

  // FETCH PRODUCTS BY CATEGORY
  Future<void> fetchProductsByCategory(String category) async {
    try {
      _isCategoryProductsLoading = true;
      //notifyListeners();
      final url =Uri.parse('https://dummyjson.com/products/category/$category');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> productsJson = data['products'] ?? [];
        _categoryProducts =
            productsJson.map((p) => Product.fromJson(p)).toList();
      }
    } catch (e) {
      // Handle error
    } finally {
      _isCategoryProductsLoading = false;
      notifyListeners();
    }
  }
}
