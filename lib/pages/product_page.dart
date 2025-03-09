import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_v141/data/product_data.dart';
import 'package:provider_v141/models/product_model.dart';
import 'package:provider_v141/pages/cart_page.dart';
import 'package:provider_v141/pages/favorite_page.dart';
import 'package:provider_v141/providers/cart_provider.dart';
import 'package:provider_v141/providers/favorite_provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> productList = ProductData().productList;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Shop ',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "Favorite Button",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritePage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: "Shoppin Buutton",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          Product product = productList[index];
          return Card(
            child: Consumer2<CartProvider, FavoriteProvider>(
              builder: (context, cartPorvider, favoriteProvider, child) =>
                  ListTile(
                title: Row(
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      cartPorvider.items.containsKey(product.id)
                          ? cartPorvider.items[product.id]!.quantity.toString()
                          : "0",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  "\$ ${product.price.toString()}",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (favoriteProvider.isFavorite(product.id)) {
                          favoriteProvider.removedFavProduct(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Removed from Favorite")));
                        } else {
                          favoriteProvider.addFavProducts(
                              product.id, product.title, product.price);
                          favoriteProvider.toggleFavorite(product.id);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Added to Favorite")));
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: favoriteProvider.isFavorite(product.id)
                            ? Colors.redAccent
                            : Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cartPorvider.addItem(
                          product.id,
                          product.price,
                          product.title,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Added to cart"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: cartPorvider.items.containsKey(product.id)
                            ? Colors.orangeAccent
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
