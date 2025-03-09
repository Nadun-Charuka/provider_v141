import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_v141/models/cart_model.dart';
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
        builder: (context, cartProvider, child) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.items.length,
                itemBuilder: (context, index) {
                  CartItem cartItem = cartProvider.items.values.toList()[index];
                  return Card(
                    color: Color.fromARGB(255, 244, 239, 239),
                    child: ListTile(
                      title: Text(cartItem.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cartItem.id),
                          Text(cartItem.quantity.toString()),
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
                              cartItem.quantity >= 2
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
                                      " ${cartProvider.items.values.toList()[index].title} removed from cart"),
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
        ),
      ),
    );
  }
}
