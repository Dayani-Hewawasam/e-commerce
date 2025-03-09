// import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ProductAddPage extends StatefulWidget {
//   @override
//   _ProductAddPageState createState() => _ProductAddPageState();
// }

// class _ProductAddPageState extends State<ProductAddPage> {
//   final _nameController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _detailController =
//       TextEditingController(); // New field for product details
//   String _selectedCategory = '';
//   Uint8List? _imageBytes;
//   String? _imageUrl;

//   // Pick an image from the gallery
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       final bytes = await pickedImage.readAsBytes();
//       setState(() {
//         _imageBytes = bytes;
//       });
//     }
//   }

//   // Upload the image to Firebase Storage
//   Future<void> _uploadImage() async {
//     if (_imageBytes != null) {
//       try {
//         final fileName = DateTime.now().millisecondsSinceEpoch.toString();
//         final storageRef =
//             FirebaseStorage.instance.ref().child('images/$fileName');
//         final uploadTask = await storageRef.putData(_imageBytes!);
//         _imageUrl = await uploadTask.ref.getDownloadURL();

//         print('Image uploaded successfully. URL: $_imageUrl');
//       } catch (e) {
//         print('Error uploading image: $e');
//         _imageUrl = null;
//       }
//     }
//   }

//   // Add the product to Firestore
//   Future<void> _addProduct() async {
//     if (_nameController.text.isNotEmpty &&
//         _priceController.text.isNotEmpty &&
//         _detailController.text.isNotEmpty &&
//         _selectedCategory.isNotEmpty &&
//         _imageBytes != null) {
//       await _uploadImage(); // Upload image and get its URL

//       if (_imageUrl != null) {
//         final firestoreRef =
//             FirebaseFirestore.instance.collection(_selectedCategory);
//         await firestoreRef.add({
//           'name': _nameController.text,
//           'price': _priceController.text, // Store price as a string
//           'detail': _detailController.text, // Adding the detail field
//           'imageUrl': _imageUrl, // Save the valid image URL
//         });

//         // Clear the form fields and state
//         _nameController.clear();
//         _priceController.clear();
//         _detailController.clear(); // Clear the detail field
//         setState(() {
//           _imageBytes = null;
//           _selectedCategory = '';
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Product added successfully!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to upload image. Please try again.')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please complete all fields.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Product'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Product Name'),
//               ),
//               TextField(
//                 controller: _priceController,
//                 decoration: InputDecoration(labelText: 'Product Price'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: _detailController,
//                 decoration: InputDecoration(
//                     labelText: 'Product Detail'), // Input for detail
//               ),
//               DropdownButton<String>(
//                 value: _selectedCategory.isEmpty ? null : _selectedCategory,
//                 hint: Text('Select Category'),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedCategory = newValue!;
//                   });
//                 },
//                 items: <String>[
//                   'mini_dress',
//                   'maxi_midi_dress',
//                   't_shirt_blouses'
//                 ].map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value.replaceAll('_', ' ').toUpperCase()),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: Text('Pick Image'),
//               ),
//               if (_imageBytes != null)
//                 Image.memory(
//                   _imageBytes!,
//                   height: 150,
//                   fit: BoxFit.cover,
//                 ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _addProduct,
//                 child: Text('Add Product'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddPage extends StatefulWidget {
  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailController = TextEditingController();
  final _imageUrlController = TextEditingController(); // For manual image URL
  String _selectedCategory = '';
  Uint8List? _imageBytes;
  String? _uploadedImageUrl;

  // Pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _imageUrlController.clear(); // Clear manual URL if an image is picked
      });
    }
  }

  // Upload the image to Firebase Storage
  Future<void> _uploadImage() async {
    if (_imageBytes != null) {
      try {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef =
            FirebaseStorage.instance.ref().child('images/$fileName');
        final uploadTask = await storageRef.putData(_imageBytes!);
        _uploadedImageUrl = await uploadTask.ref.getDownloadURL();
        print('Image uploaded successfully: $_uploadedImageUrl');
      } catch (e) {
        print('Error uploading image: $e');
        _uploadedImageUrl = null;
      }
    }
  }

  // Add the product to Firestore
  Future<void> _addProduct() async {
    if (_nameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _detailController.text.isNotEmpty &&
        _selectedCategory.isNotEmpty) {
      String? finalImageUrl;

      // If an image is uploaded, use the uploaded URL
      if (_imageBytes != null) {
        await _uploadImage();
        finalImageUrl = _uploadedImageUrl;
      } else if (_imageUrlController.text.isNotEmpty) {
        finalImageUrl = _imageUrlController.text; // Use the manual URL
      }

      if (finalImageUrl != null) {
        final firestoreRef =
            FirebaseFirestore.instance.collection(_selectedCategory);
        await firestoreRef.add({
          'name': _nameController.text,
          'price': _priceController.text,
          'detail': _detailController.text,
          'imageUrl': finalImageUrl, // Save the manual or uploaded image URL
        });

        // Clear the form fields
        _nameController.clear();
        _priceController.clear();
        _detailController.clear();
        _imageUrlController.clear();
        setState(() {
          _imageBytes = null;
          _uploadedImageUrl = null;
          _selectedCategory = '';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Please upload an image or enter an image URL.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _detailController,
                decoration: InputDecoration(labelText: 'Product Detail'),
              ),
              DropdownButton<String>(
                value: _selectedCategory.isEmpty ? null : _selectedCategory,
                hint: Text('Select Category'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: <String>[
                  'mini_dress',
                  'maxi_midi_dress',
                  't_shirt_blouses'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.replaceAll('_', ' ').toUpperCase()),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  labelText: 'Image URL (Optional)',
                  hintText: 'Enter image URL or pick an image',
                ),
                onChanged: (value) {
                  setState(() {
                    _imageBytes = null; // Clear picked image if URL is entered
                  });
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              if (_imageBytes != null)
                Image.memory(
                  _imageBytes!,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              if (_imageUrlController.text.isNotEmpty)
                Image.network(
                  _imageUrlController.text,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Text('Invalid image URL');
                  },
                ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
