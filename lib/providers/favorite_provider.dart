import 'package:flutter/material.dart';
import 'package:provider_v141/models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final Map<String, Product> _favProductMap = {};

// Map.unmodifiable(_favProductMap); -  Prevents direct modification of _favProductMap from outside the provider.Ensures that changes can only happen inside the FavoriteProvider class.
  Map<String, Product> get favProduct => Map.unmodifiable(_favProductMap);

  void toggleFavorite(String id, String title, double price) {
    if (_favProductMap.containsKey(id)) {
      // If the product is already in favorites, just remove it
      _favProductMap.remove(id);
    } else {
      // If the product is not in favorites, add it
      _favProductMap[id] =
          Product(id: id, title: title, price: price, isFavortie: true);
    }
    notifyListeners();
  }

//can use to check wether its click or unclicked
  bool isFavorite(String id) {
    return _favProductMap[id]?.isFavortie ?? false;
  }

  void removeFavProduct(String id) {
    _favProductMap.remove(id);
    notifyListeners();
  }
}
