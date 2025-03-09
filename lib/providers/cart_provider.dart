import 'package:flutter/material.dart';
import 'package:provider_v141/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  //cart item state
  final Map<String, CartItem> _items = {};

  //getter
  Map<String, CartItem> get items {
    // ... spread operator
    return {..._items};
  }

  //add item
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //_items.update(key, update)
      _items.update(
        //productId become the key
        productId,
        // (existingCartItem) {
        //   return CartItem(
        //     id: existingCartItem.id,
        //     title: existingCartItem.title,
        //     price: existingCartItem.price,
        //     quantity: existingCartItem.quantity + 1,
        //   );
        // }
        //arrow fuction

        //existingCartItem is just the name of the parameter that holds the current data (like a snapshot or copy) of the item.
        //existingCartItem refers to the current CartItem object associated with the productId.
        (exsistingCartItem) => CartItem(
          id: exsistingCartItem.id,
          title: exsistingCartItem.title,
          price: exsistingCartItem.price,
          quantity: exsistingCartItem.quantity + 1,
        ),
      );
      debugPrint("Added existing data");
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
      debugPrint("Added new data");
    }
    notifyListeners();
  }

  void decrementItemCount(int index) {
    _items.values.toList()[index].quantity--;
    notifyListeners();
  }

  void incrementItemCount(int index) {
    _items.values.toList()[index].quantity++;
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
