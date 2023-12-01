import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_module/components/ui/cart_list_tile.dart';
import 'package:product_module/view/cart/user_cart_state.dart';
import 'package:provider/provider.dart';

class UserCart extends StatelessWidget {
  const UserCart({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UserCartState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        title: Text(
          "Cart",
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
      ),
      body: state.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue.shade900,
              ),
            )
          // : Placeholder()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: state.userCartItems.length,
                      // controller: state.controller,
                      itemBuilder: (context, index) {
                        final cartItem = state.userCartItems[index];
                        return CartListTile(product: cartItem);
                      }),
                ),
              ],
            ),
    );
  }
}
