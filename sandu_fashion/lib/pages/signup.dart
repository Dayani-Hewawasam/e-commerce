import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:sandu_fashion/pages/bottomnav.dart';
import 'package:sandu_fashion/pages/home.dart';

import 'package:sandu_fashion/pages/login.dart';
import 'package:sandu_fashion/services/shared_pref.dart';
import 'package:sandu_fashion/widget/support_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? name, email, password;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (email != null && name != null && password != null) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: const Text(
              "User Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            )));
        String Id = randomAlphaNumeric(10);
        await SharedPreferenceHelper().saveUserEmail(mailcontroller.text);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserName(namecontroller.text);
        await SharedPreferenceHelper().saveUserImage("");
        Map<String, dynamic> userInfoMap = {
          "name": namecontroller.text,
          "email": mailcontroller.text,
          "Id": Id,
                
                
        };
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bottomnav()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: const Text(
                "The password provided is too weak.",
                style: TextStyle(fontSize: 20.0),
              )));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: const Text(
                "The account already exists for that email.",
                style: TextStyle(fontSize: 20.0),
              )));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: const Text(
              "Error Occured",
              style: TextStyle(fontSize: 20.0),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            margin: EdgeInsets.only(
                top: 40.0, left: 20.0, right: 20.0, bottom: 40.0),
            child: Form(
              // key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("images/hero2.png", width: 400.0),
                  Center(
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: AppWidget.semiboldTextFeildStyle(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      "Please enter the details below to\n                      continue.",
                      style: AppWidget.lightTextFeildStyle(),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "Name",
                    style: AppWidget.semiboldTextFeildStyle(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 226, 238),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }

                        return null;
                      },
                      controller: namecontroller,

                      //  controller: emailcontroller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your Name"),
                    ),
                  ),
                  Text(
                    "Email",
                    style: AppWidget.semiboldTextFeildStyle(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 226, 238),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }

                        return null;
                      },
                      controller: mailcontroller,

                      //  controller: emailcontroller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your Email"),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Password",
                    style: AppWidget.semiboldTextFeildStyle(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 226, 238),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }

                        return null;
                      },
                      controller: passwordcontroller,

                      //controller: passwordcontroller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your Password"),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  GestureDetector(
                    /*onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          email = emailcontroller.text;
                          password = passwordcontroller.text;
                        });
                      }
                      userLogin();
                    },*/

                    child: GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            name = namecontroller.text;
                            email = mailcontroller.text;
                            password = passwordcontroller.text;
                          });
                          registration();
                        }
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text("SIGNUP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: AppWidget.lightTextFeildStyle(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

    /*const Scaffold(
      body: SingleChildScrollView(
          /* child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/logo.jpg", width: 1000),
                Center(
                  child: Text(
                    "Sign Up",
                    style: AppWidget.semiBoldTextFeildStyle(),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Text(
                    "Please enter the details below to\n                      continue.",
                    style: AppWidget.LightTextFeildStyle(),
                  ),
                ),
                const SizedBox(height: 40.0),
                Text("Name", style: AppWidget.semiBoldTextFeildStyle()),
                const SizedBox(height: 20.0),
                _buildTextField("Name", namecontroller),
                const SizedBox(height: 20.0),
                Text("Email", style: AppWidget.semiBoldTextFeildStyle()),
                const SizedBox(height: 20.0),
                _buildTextField("Email", emailcontroller),
                const SizedBox(height: 20.0),
                Text("Password", style: AppWidget.semiBoldTextFeildStyle()),
                const SizedBox(height: 20.0),
                _buildTextField("Password", passwordcontroller,
                    obscureText: true),
                const SizedBox(height: 50.0),
                _buildSignUpButton(),
                const SizedBox(height: 20.0),
                _buildSignInLink(),
              ],
            ),
          ),
        ), */
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $hintText';
          }
          return null;
        },
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: () {
        /*if (_formkey.currentState!.validate()) {
          setState(() {
            name = namecontroller.text;
            email = emailcontroller.text;
            password = passwordcontroller.text;
          });
          registration();
        }*/
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: const Center(
              child: Text("SIGN UP",
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
      children: [
        Text("Already have an account? ",
            style: AppWidget.lightTextFeildStyle()),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: const Text("Sign In",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );    */
  }
}
