class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> colors;
  final bool isNew;
  final bool isFeatured;
  final String category;
  final String arFilterPath;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.colors,
    this.isNew = false,
    this.isFeatured = false,
    required this.category,
    required this.arFilterPath,
  });
}