import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sandu_fashion/Admin/home_admin.dart';
import 'package:sandu_fashion/pages/bottomnav.dart';

class AppWidget {
  static TextStyle semiBoldTextFeildStyle() {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
    );
  }
}

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'images/SachiProfile.jpeg',
                  height: MediaQuery.of(context).size.height *
                      0.3, // Adjust height as needed
                  width: MediaQuery.of(context).size.width, // Full screen width
                  fit: BoxFit.contain,
                ),
                Center(
                  child: Text(
                    " Admin Panel",
                    style: AppWidget.semiBoldTextFeildStyle(),
                  ),
                ),
                const SizedBox(height: 40.0),
                Text("UserName", style: AppWidget.semiBoldTextFeildStyle()),
                const SizedBox(height: 20.0),
                _buildTextField("Username", usernamecontroller),
                const SizedBox(height: 20.0),
                Text("Password", style: AppWidget.semiBoldTextFeildStyle()),
                const SizedBox(height: 20.0),
                _buildTextField("Password", userpasswordcontroller,
                    obscureText: true),
                const SizedBox(height: 50.0),
                _buildSignUpButton(),
                const SizedBox(height: 20.0),
                _buildSignInLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller,
      {bool obscureText = false}) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color(0xfff4f5f9),
          borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: () {
        loginAdmin();
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: const Center(
              child: Text("LOGIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold))),
        ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['username'] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: const Text(
                "You are successfully logged in",
                style: TextStyle(fontSize: 20.0),
              )));
        } else if (result.data()['password'] !=
            userpasswordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: const Text(
                "You Id is not correct",
                style: TextStyle(fontSize: 20.0),
              )));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeAdmin()));
        }
      });
    });
  }
}
