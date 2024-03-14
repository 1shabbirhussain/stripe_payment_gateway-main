import 'dart:convert';

import 'package:avildo_test/Models/product_post_model.dart';
import 'package:avildo_test/Screens/product_detail_view.dart';
import 'package:avildo_test/Screens/product_detail_view_path_parameter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  // ------------------ api get data start------------------------

  Future<List<ProductPostModel>> getProducts() async {
    List<ProductPostModel> allProducts = [];
    var url = Uri.https('fakestoreapi.com', '/products');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    for (var i in responseBody) {
      allProducts.add(ProductPostModel.fromJson(i));
    }
    return allProducts;
  }
  // ------------------ api get data end------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ----------------------App Bar Start----------------
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Center(
            child: Text(
          "Products",
          style: TextStyle(color: Colors.white),
        )),
        actions: const [
          Icon(Icons.shopping_cart_sharp, color: Colors.white
              // sizre: 20,
              ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.menu, color: Colors.white
              // size: 20,
              ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      // ----------------------App Bar End----------------

      body: Padding(
        padding: const EdgeInsets.all(15),
        // ---------------------FUTURE BUILDER---------------
        child: FutureBuilder(
            future: getProducts(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductPostModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black87,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // -------------------------------gridview Builder Start-----------
                return DynamicHeightGridView(
                    itemCount: snapshot.data!.length,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    crossAxisCount: 2,
                    builder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            // return ProductDetailView(
                            //     product: snapshot.data![index]);
                            return ProductDetailViewPath(id: "${snapshot.data![index].id}");
                          }));
                        },
                        child: Material(
                          elevation: 5,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.network(
                                    "${snapshot.data![index].image}",
                                    width: 120,
                                    height: 150,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${snapshot.data![index].title}",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                Text("${snapshot.data![index].category}"),
                                Text(
                                  "Available: ${snapshot.data![index].rating?.count ?? 0}",
                                ),
                                Text(
                                  "\$${snapshot.data![index].price}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Text('No data available');
              }
            }),
      ),
    );
  }
}
