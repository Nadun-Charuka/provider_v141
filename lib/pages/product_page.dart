import 'package:flutter/material.dart';
import 'package:provider_v141/data/product_data.dart';
import 'package:provider_v141/models/product_model.dart';

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
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          Product product = productList[index];
          return Card(
            child: ListTile(
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
                  //todo fill this
                  Text("0"),
                ],
              ),
              subtitle: Text(
                "\$ ${product.price.toString()}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
