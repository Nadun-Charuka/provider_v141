import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_v141/providers/favorite_provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Page ',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) => ListView.builder(
          itemCount: favoriteProvider.favProduct.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              title: Text(
                favoriteProvider.favProduct.values
                    .toList()[index]
                    .title
                    .toString(),
              ),
              subtitle: Text(
                favoriteProvider.favProduct.values
                    .toList()[index]
                    .price
                    .toString(),
              ),
              trailing: IconButton(
                onPressed: () {
                  favoriteProvider.removedFavProduct(
                      favoriteProvider.favProduct.values.toList()[index].id);
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
