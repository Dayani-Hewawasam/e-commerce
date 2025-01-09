/* import 'package:flutter/material.dart';
import 'package:sandu_fashion/widget/support_widget.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfef5f1),
      body: Container(
        padding: const EdgeInsets.only(
          top: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Go back when tapped
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ),
              Center(
                  child: Image.asset(
                "images/blackblouse-3.jpeg",
                height: 400,
              ))
            ]),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("blackBlouse",
                            style: AppWidget.BoldTextFeildStyle()),
                        const Text("\$300",
                            style: TextStyle(
                                color: Color(0xFFfd6f9e),
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text("Details", style: AppWidget.semiboldTextFeildStyle()),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                        "Elegant black blouse with a chic, tailored fit. Perfect for both casual and formal occasions, featuring soft, breathable fabric and a sleek silhouette. A must-have versatile piece for any wardrobe!"),
                    const SizedBox(
                      height: 90.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFfd6f9e),
                          borderRadius: BorderRadius.circular(10.0)),
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                          child: Text(
                        "Buy Now",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
} */

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sandu_fashion/widget/support_widget.dart';

class ProductDetail extends StatefulWidget {
  final String name, image, price, detail;

  ProductDetail({
    required this.name,
    required this.price,
    required this.detail,
    required this.image,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    // Price is kept as String
    String price = widget.price;

    return Scaffold(
      backgroundColor: const Color(0xFFfef5f1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFfef5f1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context); // Go back
          },
        ),
        title: Text(widget.name),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            Center(
              child: widget.image.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: widget.image,
                      height: 400,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Image.network('https://via.placeholder.com/400'),
                      errorWidget: (context, url, error) =>
                          Image.network('https://via.placeholder.com/400'),
                    )
                  : Image.network(
                      'https://via.placeholder.com/400', // Placeholder image URL
                      height: 400,
                      fit: BoxFit.cover,
                    ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name and Price Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: AppWidget.boldTextFeildStyle(),
                          ),
                          Text(
                            "\$${price}", // Price displayed as a string
                            style: const TextStyle(
                              color: Color(0xFFfd6f9e),
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      // Product Details Section
                      Text(
                        "Details",
                        style: AppWidget.semiBoldTextFeildStyle(),
                      ),
                      const SizedBox(height: 20.0),
                      Text(widget.detail),
                      const SizedBox(height: 20.0),
                      // Buy Now Button Section
                      GestureDetector(
                        onTap: () {
                          // Implement Buy Now functionality here
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFfd6f9e),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text(
                              "Buy Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
