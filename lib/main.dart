import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_v141/pages/product_page.dart';
import 'package:provider_v141/providers/cart_provider.dart';
import 'package:provider_v141/providers/favorite_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}
