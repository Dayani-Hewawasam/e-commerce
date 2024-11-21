import 'package:flutter/material.dart';
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
      backgroundColor: Color(0xFFfef5f1),
      body: Container(
        padding: EdgeInsets.only(
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
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.arrow_back_ios_new_outlined),
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
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                decoration: BoxDecoration(
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
                        Text("\$300",
                            style: TextStyle(
                                color: Color(0xFFfd6f9e),
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text("Details", style: AppWidget.semiboldTextFeildStyle()),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                        "Elegant black blouse with a chic, tailored fit. Perfect for both casual and formal occasions, featuring soft, breathable fabric and a sleek silhouette. A must-have versatile piece for any wardrobe!"),
                    SizedBox(
                      height: 90.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFfd6f9e),
                          borderRadius: BorderRadius.circular(10.0)),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
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
}
