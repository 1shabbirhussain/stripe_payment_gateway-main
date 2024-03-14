import 'package:avildo_test/Models/product_post_model.dart';
import 'package:flutter/material.dart';

class ProductDetailView extends StatefulWidget {
  final ProductPostModel product;
  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {


  
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
            )),
        title: const Center(
            child: Text(
          "Products Details",
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.network(
                "${widget.product.image}",
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
                      "${widget.product.title}",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                    Text("${widget.product.category}",
                        style:
                            TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    const SizedBox(height: 15),
                    Text("${widget.product.description}"),
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
                        Text("\$${widget.product.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 26)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
