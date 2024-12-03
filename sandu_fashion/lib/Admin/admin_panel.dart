import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final String category; // Pass the selected category

  ProductListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.replaceAll('_', ' ').toUpperCase()),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(category).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final products = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final imageUrl = product['imageUrl'];

              // Debugging: Print the image URL to the console
              print('Image URL: $imageUrl');

              // Check if image URL is empty or null and provide a default image if necessary
              final displayImageUrl = imageUrl?.isNotEmpty == true
                  ? imageUrl
                  : 'https://via.placeholder.com/150'; // Default image URL

              return Card(
                child: ListTile(
                  title: Text(product['name']),
                  subtitle: Text('\$${product['price']}'), // Price is now a string
                  leading: Image.network(
                    displayImageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, size: 50);
                    },
                  ),
                  // Navigator Button to Product Detail Page
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          name: product['name'],
                          detail: product['detail'],
                          price: product['price'], // Price is passed as a string
                          imageUrl: displayImageUrl,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String name;
  final String detail;
  final String price; // Change price to String
  final String imageUrl;

  ProductDetailPage({
    required this.name,
    required this.detail,
    required this.price, // Updated to String type
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                imageUrl,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.broken_image, size: 200);
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Price: \$${price}', // Price is treated as a string
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              detail,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}