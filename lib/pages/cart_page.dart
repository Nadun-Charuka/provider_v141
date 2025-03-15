import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_v141/models/product_model.dart';

import 'package:provider_v141/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart Page',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cartItemsMap.isEmpty) {
            return Center(
                child: Text(
              "No Items in cart",
              style: TextStyle(fontSize: 30),
            ));
          }

          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Total:",
                        style: TextStyle(
                            fontSize: 25), // Default style for all text
                        children: [
                          TextSpan(
                            text: " ${cartProvider.totalPrice()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " \$",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          cartProvider.clearCart();
                        },
                        child: Text("Clear Cart"))
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.cartItemsMap.length,
                  itemBuilder: (context, index) {
                    Product cartItem =
                        cartProvider.cartItemsMap.values.toList()[index];
                    return Card(
                      color: Color.fromARGB(255, 244, 239, 239),
                      child: ListTile(
                        title: Text(cartItem.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItem.id),
                            Text(cartItem.cartAddedQuantity.toString()),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cartProvider.incrementItemCount(index);
                              },
                              icon: Icon(
                                Icons.add,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cartItem.cartAddedQuantity >= 2
                                    ? cartProvider.decrementItemCount(index)
                                    : cartProvider.removeFromCart(cartItem.id);
                              },
                              icon: Icon(
                                Icons.remove,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cartProvider.removeFromCart(cartItem.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        " ${cartItem.title} removed from cart"),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.remove_shopping_cart,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
