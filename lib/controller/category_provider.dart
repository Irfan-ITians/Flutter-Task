import 'dart:convert';
import 'package:check/models/category.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  bool _isCategoryLoading = false;

  bool get isCategoryLoading => _isCategoryLoading;
  List<CategoryModel> get categories => _categories;

  // FETCH CATEGORIES
  Future<void> fetchCategories() async {
    try {
      _isCategoryLoading = true;
      notifyListeners();

      final url = Uri.parse('https://dummyjson.com/products/categories');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('Category data: $data');
        _categories = data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      _isCategoryLoading = false;
      notifyListeners();
    }
  }

  // FILTERED CATEGORIES (SEARCH)
  List<CategoryModel> filteredCategories(String query) {
    if (query.isEmpty) {
      return _categories;
      
    }
    return _categories
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
