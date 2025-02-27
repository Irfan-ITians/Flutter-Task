import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  bool isFavorite(Product product) {
    return _favorites.any((fav) => fav.id == product.id);
  }

  void addToFavorites(Product product) {
    if (!isFavorite(product)) {
      _favorites.add(product);
      notifyListeners();
    }
  }

  void removeFromFavorites(Product product) {
    _favorites.removeWhere((fav) => fav.id == product.id);
    notifyListeners();
  }
}
