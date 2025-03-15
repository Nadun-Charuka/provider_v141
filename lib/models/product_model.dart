class Product {
  final String id;
  final String title;
  final double price;
  bool isFavortie;
  int cartAddedQuantity;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.isFavortie = false,
    this.cartAddedQuantity = 0,
  });
}
