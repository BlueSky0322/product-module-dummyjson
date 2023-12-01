import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_module/components/ui/custom_search_field.dart';
import 'package:product_module/components/ui/product_list_tile.dart';
import 'package:product_module/utils/price_sorting.dart';
import 'package:product_module/view/cart/user_cart.dart';
import 'package:product_module/view/cart/user_cart_state.dart';
import 'package:product_module/view/product/product_state.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductPageState>(context);
    final filteredProducts = state.productsList.where((product) {
      return state.selectedCategories.isEmpty ||
          state.selectedCategories.contains(product.category);
    }).toList();

    // if (state.selectedSorting == PriceSorting.lowToHigh) {
    //   filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    // } else {
    //   filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade50,
        title: Text(
          "All Products",
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
              state.firstLoad();
            },
            icon: const Icon(Icons.replay_outlined),
            color: Colors.blue,
            hoverColor: Colors.blue,
          ),
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
      body: state.isFirstLoadRunning
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue.shade900,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomSearchField(
                            onChanged: (String value) {
                              if (value.isNotEmpty) {
                                state.searchProduct(value);
                              } else {
                                state.restoreList();
                              }
                            },
                            onPressed: () {
                              state.clearControllers();
                            },
                            labelText: "Search & Filter",
                            hintText: "Search for something...",
                            controller: state.searchController),
                      ),
                      _horiGap(),
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return ValueListenableBuilder<bool>(
                                    valueListenable: state.selected,
                                    builder: (context, selected, _) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _vertGap(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Text(
                                                  "Sort by category",
                                                  style: GoogleFonts.outfit(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              _vertGap(),
                                              Container(
                                                child: Wrap(
                                                  spacing: 8,
                                                  alignment:
                                                      WrapAlignment.start,
                                                  runAlignment: WrapAlignment
                                                      .spaceBetween,
                                                  children: state.categories
                                                      .map((category) =>
                                                          FilterChip(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              shape:
                                                                  const StadiumBorder(
                                                                side:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black12,
                                                                ),
                                                              ),
                                                              label: Text(
                                                                category,
                                                                style:
                                                                    GoogleFonts
                                                                        .outfit(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ),
                                                              selected: state
                                                                  .selectedCategories
                                                                  .contains(
                                                                      category),
                                                              onSelected:
                                                                  (selected) {
                                                                if (selected) {
                                                                  state.enableChip(
                                                                      category);
                                                                } else {
                                                                  state.disableChip(
                                                                      category);
                                                                }
                                                              }))
                                                      .toList(),
                                                ),
                                              ),
                                              _vertGap(),
                                              const Divider(
                                                thickness: 3,
                                              ),
                                              _vertGap(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Text(
                                                  "Sort by price",
                                                  style: GoogleFonts.outfit(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              _vertGap(),
                                              Wrap(
                                                spacing: 8,
                                                alignment: WrapAlignment.start,
                                                runAlignment:
                                                    WrapAlignment.spaceBetween,
                                                children: <Widget>[
                                                  FilterChip(
                                                    shape: const StadiumBorder(
                                                      side: BorderSide(
                                                        color: Colors.black12,
                                                      ),
                                                    ),
                                                    label: Text(
                                                      'Price-Low to High',
                                                      style: GoogleFonts.outfit(
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    selected: state
                                                            .selectedSorting ==
                                                        PriceSorting.lowToHigh,
                                                    onSelected: (isSelected) {
                                                      state.enablePriceChip();
                                                      state.selectedSorting =
                                                          isSelected
                                                              ? PriceSorting
                                                                  .lowToHigh
                                                              : null;
                                                      state
                                                          .sortProductsByPrice(); // Sort products
                                                    },
                                                  ),
                                                  FilterChip(
                                                    shape: const StadiumBorder(
                                                      side: BorderSide(
                                                        color: Colors.black12,
                                                      ),
                                                    ),
                                                    label: Text(
                                                      'Price-High to Low',
                                                      style: GoogleFonts.outfit(
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    selected: state
                                                            .selectedSorting ==
                                                        PriceSorting.highToLow,
                                                    onSelected: (isSelected) {
                                                      state.enablePriceChip();
                                                      state.selectedSorting =
                                                          isSelected
                                                              ? PriceSorting
                                                                  .highToLow
                                                              : null;
                                                      state
                                                          .sortProductsByPrice(); // Sort products
                                                    },
                                                  ),
                                                  _vertGap(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                        ),
                        child: const Icon(
                          Icons.more_horiz_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: filteredProducts.length,
                      controller: state.controller,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ProductListTile(product: product);
                      }),
                ),
                if (state.isLoadMoreRunning == true)
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.lightBlue.shade900,
                      ),
                    ),
                  ),
                if (state.hasNextPage == false &&
                    state.enableBacktToTop == true)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 8, 100, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              state.backToTop();
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
                              "Back to Top",
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
              ],
            ),
    );
  }
}

Widget _vertGap() => const SizedBox(height: 16);
Widget _horiGap() => const SizedBox(width: 16);
