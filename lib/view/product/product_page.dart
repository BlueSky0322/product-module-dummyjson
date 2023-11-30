import 'package:flutter/material.dart';
import 'package:product_module/view/product/product_state.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductPageState>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: state.isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.productsList.length,
                    // controller: _controller,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: ListTile(
                        title: Text(state.productsList[index].title),
                        subtitle:
                            Text(state.productsList[index].rating.toString()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
