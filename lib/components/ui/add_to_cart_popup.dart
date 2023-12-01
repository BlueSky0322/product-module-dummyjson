import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:product_module/data/product.dart';
import 'package:product_module/view/product/product_details/product_details_state.dart';

// ignore: must_be_immutable
class PreorderPopup extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final ProductDetailsState state;
  final Product product;

  PreorderPopup({
    super.key,
    required this.state,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey.shade50,
      title: Text(
        "Add to Cart",
        style: GoogleFonts.outfit(
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
              child: Image.network(
                product.thumbnail,
                width: 350,
                fit: BoxFit.fitHeight,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.amber,
                    ), // Set the background color here
                    width: 100,
                    height: 20,
                    child: Center(
                      child: Text(
                        "Only ${product.stock} left!",
                        style: GoogleFonts.outfit(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  product.title,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    textStyle: TextStyle(
                      color: Colors.lightBlue.shade900,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "RM ${product.price.toStringAsFixed(2)}",
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "${product.discountPercentage.toStringAsFixed(2)}% OFF",
                  style: GoogleFonts.outfit(
                    textStyle: TextStyle(
                      color: Colors.red.shade900,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 150,
                    child: InputQty(
                      maxVal: 50,
                      initVal: 1,
                      minVal: 0,
                      steps: 1,
                      isIntrinsicWidth: true,
                      decoration: const QtyDecorationProps(
                        borderShape: BorderShapeBtn.none,
                        plusBtn: Icon(Icons.add_box),
                        minusBtn: Icon(Icons.indeterminate_check_box),
                        btnColor: Colors.black,
                      ),
                      onQtyChanged: (val) {
                        int intValue = val.toInt();
                        state.quantity = intValue;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      width: 2,
                      color: Colors.lightBlue.shade900,
                    ),
                  ),
                ),
              ),
              // onPressed: confirmButtonPressed,
              child: Text(
                'Confirm',
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  state.productId = product.id;
                  log("${state.quantity} ${state.productId}");

                  bool updateSuccess = await state.addToCart();
                  Future.microtask(
                    () => Navigator.pop(context),
                  );
                  Future.microtask(() {
                    if (updateSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Adding item to cart...'),
                        backgroundColor: Colors.green.shade300,
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Something went wrong.'),
                        backgroundColor: Colors.red.shade300,
                      ));
                    }
                  });
                }
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.red.shade700,
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
