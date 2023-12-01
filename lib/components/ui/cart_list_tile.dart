import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_module/data/cart.dart';

class CartListTile extends StatelessWidget {
  final CartProduct product;
  const CartListTile({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey.shade100,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        leading: Image.network(
          product.thumbnail,
          fit: BoxFit.fitHeight,
          width: 50,
          height: 100,
        ),
        title: Text(
          product.title,
          style: GoogleFonts.outfit(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "RM ${product.price.toStringAsFixed(2)} X ${product.quantity}",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "RM ${product.total.toStringAsFixed(2)}",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      " saved ${product.discountPercentage.toStringAsFixed(2)}%",
                      style: GoogleFonts.outfit(
                        textStyle: TextStyle(
                          color: Colors.lightBlue.shade900,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.discount,
                      color: Colors.amber.shade700,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
