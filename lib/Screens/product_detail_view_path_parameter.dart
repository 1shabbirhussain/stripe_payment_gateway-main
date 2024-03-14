import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:avildo_test/Models/product_post_model.dart';
import 'package:flutter/material.dart';

class ProductDetailViewPath extends StatefulWidget {
  final String id;
  const ProductDetailViewPath({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetailViewPath> createState() => _ProductDetailViewPathState();
}

class _ProductDetailViewPathState extends State<ProductDetailViewPath> {

// -------------------API Call--------------------
  Future<ProductPostModel> getProductDetail() async {
    var url = Uri.https('fakestoreapi.com', '/products/${widget.id}');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    return ProductPostModel.fromJson(responseBody);
  }
// -------------------API Call--------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ----------------------App Bar Start----------------
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            return Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Center(
          child: Text(
            "Products Details",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: const [
          Icon(
            Icons.shopping_cart_sharp,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.menu,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      // ----------------------App Bar End----------------
      // ------------------Body Start---------------
      body: FutureBuilder(
        future: getProductDetail(),
        builder: (BuildContext context, AsyncSnapshot<ProductPostModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black87,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Image.network(
                      snapshot.data!.image ?? "", // Use snapshot.data instead of widget.product
                      height: 200,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1,
                          color: Colors.black12,
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data!.title}", // Use snapshot.data instead of widget.product
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                          Text(
                            "${snapshot.data!.category}", // Use snapshot.data instead of widget.product
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                          const SizedBox(height: 15),
                          Text("${snapshot.data!.description}"), // Use snapshot.data instead of widget.product
                          const SizedBox(height: 15),
                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.black87,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.black87,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.black87,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.black87,
                              ),
                              Icon(
                                Icons.star_border,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${snapshot.data!.price}", // Use snapshot.data instead of widget.product
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
                              ),
                              const Icon(
                                Icons.favorite_border,
                                color: Colors.black87,
                                size: 26,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.black87,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}
