class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }
}

class ProductShort {
  final int id;
  final String title;
  final double price;
  final double rating;
  final int stock;
  final String category;
  final String thumbnail;

  ProductShort({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.stock,
    required this.category,
    required this.thumbnail,
  });

  factory ProductShort.fromJson(Map<String, dynamic> json) {
    return ProductShort(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      category: json['category'],
      thumbnail: json['thumbnail'],
    );
  }
}
