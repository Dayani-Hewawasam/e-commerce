import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:sandu_fashion/pages/login.dart';
import 'package:sandu_fashion/services/shared_pref.dart';
import 'package:sandu_fashion/services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool isProcessing = false;

  Future<Map<String, String?>> getUserData() async {
    return {
      "email": await SharedPreferenceHelper().getUserEmail(),
      "name": await SharedPreferenceHelper().getUserName(),
      "image": await SharedPreferenceHelper().getUserImage(),
    };
  }

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => selectedImage = File(image.path));
      await uploadImage();
    }
  }

  Future uploadImage() async {
    if (selectedImage != null) {
      String imageId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("profileImages").child(imageId);
      UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      TaskSnapshot snapshot = await task;
      var downloadUrl = await snapshot.ref.getDownloadURL();

      await SharedPreferenceHelper().saveUserImage(downloadUrl);

      setState(() {
        selectedImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xfff2f2f2),
      body: FutureBuilder<Map<String, String?>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          String? name = snapshot.data!["name"];
          String? email = snapshot.data!["email"];
          String? image = snapshot.data!["image"];

          return Column(
            children: [
              GestureDetector(
                onTap: getImage,
                child: Center(
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : (image != null && image.isNotEmpty)
                            ? NetworkImage(image)
                            : const AssetImage('assets/default_profile.png')
                                as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              profileDetail("Name", name ?? "N/A", Icons.person_outline),
              const SizedBox(height: 20.0),
              profileDetail("Email", email ?? "N/A", Icons.mail_outline),
              const SizedBox(height: 20.0),
              actionButton(
                context,
                "Log Out",
                Icons.logout,
                () async {
                  if (isProcessing) return;
                  setState(() => isProcessing = true);
                  await AuthMethods().SignOut();
                  setState(() => isProcessing = false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              actionButton(
                context,
                "Delete Account",
                Icons.delete_outline,
                () async {
                  if (isProcessing) return;
                  setState(() => isProcessing = true);
                  await AuthMethods().deleteuser();
                  setState(() => isProcessing = false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget profileDetail(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, size: 35.0),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(value, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionButton(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, size: 35.0),
                const SizedBox(width: 10.0),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios_outlined),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
