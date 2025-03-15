class Product {
  final String id;
  final String title;
  final double price;
  bool isFavortie;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.isFavortie = false,
  });
}
