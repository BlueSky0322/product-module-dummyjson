class Cart {
  final int userId;
  final List<CartItem> products;

  Cart({
    required this.userId,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class CartItem {
  final int id;
  final int quantity;

  CartItem({
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}
