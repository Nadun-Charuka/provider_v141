import 'package:flutter/material.dart';
import 'package:provider_v141/models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final Map<String, bool> _favorites = {};
  Map<String, bool> get favorites => _favorites;

  void toggleFavorite(String id) {
    if (_favorites.containsKey(id)) {
      _favorites[id] = !_favorites[id]!;
      debugPrint("$_favorites");
    } else {
      _favorites[id] = true;
      debugPrint("$_favorites");
    }
    notifyListeners();
  }

  //check fav or not
  bool isFavorite(String id) {
    //it may return null, which is not ideal when working with booleans.By using ?? false, you ensure that the method always returns a boolean (true or false), preventing null-related errors.
    return _favorites[id] ?? false;
  }

  final Map<String, Product> _favProduct = {};
  Map<String, Product> get favProduct => _favProduct;

//add to fav page
  void addFavProducts(String id, String title, double price) {
    if (_favProduct.containsKey(id)) {
      return;
    } else {
      _favProduct.putIfAbsent(
        id,
        () => Product(id: id, title: title, price: price),
      );
    }
    notifyListeners();
  }

//remove from fav page
  void removedFavProduct(String id) {
    _favProduct.remove(id);
    _favorites.remove(id);
    notifyListeners();
  }
}
