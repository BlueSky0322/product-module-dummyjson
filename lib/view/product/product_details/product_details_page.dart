import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_module/components/ui/detail_block.dart';
import 'package:product_module/components/ui/add_to_cart_popup.dart';
import 'package:product_module/view/cart/user_cart.dart';
import 'package:product_module/view/cart/user_cart_state.dart';
import 'package:product_module/view/product/product_details/product_details_state.dart';
import 'package:product_module/view/product/product_state.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductDetailsState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade50,
        title: Text(
          "Product details",
          style: GoogleFonts.outfit(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => UserCartState(context),
                      child: const UserCart(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              color: Colors.lightBlue.shade900),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: state.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue.shade900,
              ),
            )
          : Column(children: [
              _vertGap(),
              CarouselSlider(
                items: state.product!.images
                    .map((item) => Container(
                          child: Center(
                            child: Image.network(
                              item,
                              fit: BoxFit.fitHeight,
                              width: 1000,
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
              ),
              _vertGap(),
              // _divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Column(
                      children: [
                        _innerDivider(),
                        DetailBlock(
                          labelText: 'Title',
                          valueText: state.product!.title,
                        ),
                        _innerDivider(),
                        DetailBlock(
                          labelText: 'Description',
                          valueText: state.product!.description,
                        ),
                        _innerDivider(),
                        DetailBlock(
                          labelText: 'Brand',
                          valueText: state.product!.brand,
                        ),
                        _innerDivider(),
                        DetailBlock(
                          labelText: 'Category',
                          valueText: state.product!.category,
                        ),
                        _innerDivider(),
                        DetailBlock(
                          labelText: 'Price',
                          valueText:
                              "RM ${state.product!.price.toStringAsFixed(2)}",
                        ),
                        _innerDivider(),
                        DetailBlock(
                          labelText: 'Discount Rate',
                          valueText:
                              "${state.product!.discountPercentage.toStringAsFixed(2)}%",
                        ),
                        _innerDivider(),
                        DetailBlock(
                          labelText: 'Stock',
                          valueText: "${state.product!.stock.toString()} left",
                        ),
                        _innerDivider(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 8, 100, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return PreorderPopup(
                                  state: state,
                                  product: state.product!,
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        child: Text(
                          "Add to Cart",
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
    );
  }
}

Widget _vertGap() => const SizedBox(height: 16);
Widget _divider() =>
    Divider(color: Colors.blue.shade900, thickness: 6, indent: 8, endIndent: 8);
Widget _innerDivider() => const Divider(color: Colors.black, thickness: 2);
