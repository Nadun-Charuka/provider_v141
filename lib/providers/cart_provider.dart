import 'package:flutter/material.dart';
import 'package:provider_v141/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  //cart item state
  final Map<String, Product> _cartItemsMap = {};

  //getter
  Map<String, Product> get cartItemsMap {
    // ... spread operator
    return {..._cartItemsMap};
  }

  //add item
  void addItem(String id, double price, String title) {
    if (_cartItemsMap.containsKey(id)) {
      //_items.update(key, update)
      _cartItemsMap.update(
        //productId become the key
        id,
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
        (exsistingCartItem) => Product(
          id: exsistingCartItem.id,
          title: exsistingCartItem.title,
          price: exsistingCartItem.price,
          cartAddedQuantity: exsistingCartItem.cartAddedQuantity + 1,
        ),
      );
      debugPrint("Added existing data");
    } else {
      _cartItemsMap.putIfAbsent(
        id,
        () => Product(
          id: id,
          title: title,
          price: price,
          cartAddedQuantity: 1,
        ),
      );
      debugPrint("Added new data");
    }
    notifyListeners();
  }

  void decrementItemCount(int index) {
    _cartItemsMap.values.toList()[index].cartAddedQuantity--;
    notifyListeners();
  }

  void incrementItemCount(int index) {
    _cartItemsMap.values.toList()[index].cartAddedQuantity++;
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cartItemsMap.remove(productId);
    notifyListeners();
  }

  // double totalCartPrice() {
  //   //collection.fold(initialValue, (accumulator, element) => updatedValue);
  //   /*
  //   collection → List or Map you want to process.
  //   initialValue → Starting value for accumulation.
  //   accumulator → Keeps track of the result as the loop progresses.
  //   element → Each item from the collection.
  //   updatedValue → New value to store in accumulator.
  //   */
  //   return double.parse(_cartItemsMap.values
  //       .fold(0.0, (sum, item) => sum + (item.price * item.cartAddedQuantity))
  //       .toStringAsFixed(2));
  // }

  double totalPrice() {
    var total = 0.0;
    cartItemsMap.values.toList().forEach((product) {
      total = total + product.price * product.cartAddedQuantity;
    });
    return total;
  }

  void clearCart() {
    _cartItemsMap.clear();
    notifyListeners();
  }
}
