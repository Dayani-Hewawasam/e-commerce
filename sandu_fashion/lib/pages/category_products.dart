import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sandu_fashion/pages/product_detail.dart';
import 'package:sandu_fashion/services/database.dart';

class CategoryProducts extends StatefulWidget {
  final String category;

  CategoryProducts({required this.category});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  Stream<QuerySnapshot>? categoryStream;

  @override
  void initState() {
    super.initState();
    getOnTheLoads();
  }

  getOnTheLoads() {
    DatabaseMethods().getProducts(widget.category).then((stream) {
      setState(() {
        categoryStream = stream;
      });
    });
  }

  Future<String> getImageUrl(String imagePath) async {
    try {
      if (imagePath.isEmpty) {
        return 'https://via.placeholder.com/150'; // Default image if path is empty
      }
      Reference storageReference =
          FirebaseStorage.instance.ref().child(imagePath);
      String url = await storageReference.getDownloadURL();
      return url;
    } catch (e) {
      print("Error fetching image URL: $e");
      return 'https://via.placeholder.com/150'; // Placeholder in case of error
    }
  }

  // Widget to display products in a grid
  Widget allProduct() {
    return StreamBuilder<QuerySnapshot>(
      stream: categoryStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No products found.'));
        }

        return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10.0,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];

            String imagePath = ds["imageUrl"] ?? '';
            String price = ds["price"]?.toString() ?? '0.00'; // Price as string

            return FutureBuilder<String>(
              future: getImageUrl(imagePath),
              builder: (context, imageSnapshot) {
                if (imageSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (imageSnapshot.hasError || !imageSnapshot.hasData) {
                  return Center(child: Text('Error loading image'));
                }

                String imageUrl = imageSnapshot.data ?? '';

                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10.0),
                      // Display the fetched image
                      imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  'https://via.placeholder.com/150', // Placeholder image URL
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.network(
                              'https://via.placeholder.com/150', // Placeholder image URL
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                      SizedBox(height: 20.0),
                      Text(
                        ds["name"] ?? 'No Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            "\$${price}", // Display price as string
                            style: TextStyle(
                              color: Color(0xFFfd6f3e),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                    name: ds["name"] ?? 'No Name',
                                    price: price, // Pass price as string
                                    detail: ds["detail"] ?? 'No Details',
                                    image: ds["imageUrl"] ?? '',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(0xFFfd6f3e),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        elevation: 0,
        title: Text(
          widget.category.replaceAll('_', ' ').toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: allProduct(),
      ),
    );
  }
}